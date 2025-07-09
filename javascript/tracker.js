#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const asyncHooks = require('async_hooks');
const babel = require('@babel/core');
const { VM } = require('vm2');
const _ = require('lodash');
const falafel = require('falafel');
const prettyFormat = require('pretty-format');

const traceLoops = (babel) => {
  const t = babel.types;

  const transformLoop = (path) => {
    const iterateLoop = t.memberExpression(
      t.identifier('Tracer'),
      t.identifier('iterateLoop'),
    );
    const callIterateLoop = t.callExpression(iterateLoop, []);
    path.get('body').pushContainer('body', callIterateLoop);
  };

  return {
    visitor: {
      WhileStatement: transformLoop,
      DoWhileStatement: transformLoop,
      ForStatement: transformLoop,
      ForInStatement: transformLoop,
      ForOfStatement: transformLoop,
    }
  };
};


const event = (type, payload) => ({ type, payload });
const Events = {
  ConsoleLog: (message) => event('ConsoleLog', { message }),
  ConsoleWarn: (message) => event('ConsoleWarn', { message }),
  ConsoleError: (message) => event('ConsoleError', { message }),
  EnterFunction: (id, name, start, end) => event('EnterFunction', { id, name, start, end }),
  ExitFunction: (id, name, start, end) => event('ExitFunction', { id, name, start, end }),
  ErrorFunction: (message, id, name, start, end) => event('ErrorFunction', { message, id, name, start, end }),
  InitPromise: (id, parentId) => event('InitPromise', { id, parentId }),
  ResolvePromise: (id) => event('ResolvePromise', { id }),
  BeforePromise: (id) => event('BeforePromise', { id }),
  AfterPromise: (id) => event('AfterPromise', { id }),
  InitMicrotask: (id, parentId) => event('InitMicrotask', { id, parentId }),
  BeforeMicrotask: (id) => event('BeforeMicrotask', { id }),
  AfterMicrotask: (id) => event('AfterMicrotask', { id }),
  InitTimeout: (id, callbackName) => event('InitTimeout', { id, callbackName }),
  BeforeTimeout: (id) => event('BeforeTimeout', { id }),
  UncaughtError: (error) => event('UncaughtError', {
    name: (error || {}).name,
    stack: (error || {}).stack,
    message: (error || {}).message,
  }),
  EarlyTermination: (message) => event('EarlyTermination', { message }),
};

let events = [];
const postEvent = (event) => {
  events.push(event);
  //console.log(JSON.stringify(event));
};

const ignoredAsyncHookTypes = [
  'FSEVENTWRAP', 'FSREQCALLBACK', 'GETADDRINFOREQWRAP', 'GETNAMEINFOREQWRAP',
  'HTTPPARSER', 'JSSTREAM', 'PIPECONNECTWRAP', 'PIPEWRAP', 'PROCESSWRAP',
  'QUERYWRAP', 'SHUTDOWNWRAP', 'SIGNALWRAP', 'STATWATCHER', 'TCPCONNECTWRAP',
  'TCPSERVERWRAP', 'TCPWRAP', 'TTYWRAP', 'UDPSENDWRAP', 'UDPWRAP', 'WRITEWRAP',
  'ZLIB', 'SSLCONNECTION', 'PBKDF2REQUEST', 'RANDOMBYTESREQUEST', 'TLSWRAP',
  'DNSCHANNEL',
];

const asyncIdToResource = {};

const init = (asyncId, type, triggerAsyncId, resource) => {
  asyncIdToResource[asyncId] = resource;
  if (type === 'PROMISE') {
    postEvent(Events.InitPromise(asyncId, triggerAsyncId));
  }
  if (type === 'Timeout') {
    const callbackName = resource._onTimeout.name || 'anonymous';
    postEvent(Events.InitTimeout(asyncId, callbackName));
  }
  if (type === 'Microtask') {
    postEvent(Events.InitMicrotask(asyncId, triggerAsyncId));
  }
};

const before = (asyncId) => {
  const resource = asyncIdToResource[asyncId] || {};
  const resourceName = (resource.constructor).name;
  if (resourceName === 'PromiseWrap') {
    postEvent(Events.BeforePromise(asyncId));
  }
  if (resourceName === 'Timeout') {
    postEvent(Events.BeforeTimeout(asyncId));
  }
  if (resourceName === 'AsyncResource') {
    postEvent(Events.BeforeMicrotask(asyncId));
  }
};

const after = (asyncId) => {
  const resource = asyncIdToResource[asyncId] || {};
  const resourceName = (resource.constructor).name;
  if (resourceName === 'PromiseWrap') {
    postEvent(Events.AfterPromise(asyncId));
  }
  if (resourceName === 'AsyncResource') {
    postEvent(Events.AfterMicrotask(asyncId));
  }
};

const destroy = (asyncId) => {
  // Cleanup if needed
};

const promiseResolve = (asyncId) => {
  postEvent(Events.ResolvePromise(asyncId));
};

asyncHooks
  .createHook({ init, before, after, destroy, promiseResolve })
  .enable();

const functionDefinitionTypes = [
  'FunctionDeclaration',
  'FunctionExpression',
  'ArrowFunctionExpression',
];
const arrowFnImplicitReturnTypesRegex = /Literal|Identifier|(\w)*Expression/;

const traceBlock = (code, fnName, start, end) => `{
  const idWithExtensionToAvoidConflicts = nextId();
  Tracer.enterFunc(idWithExtensionToAvoidConflicts, '${fnName}', ${start}, ${end});
  try {
    ${code}
  } catch (e) {
    Tracer.errorFunc(e.message, idWithExtensionToAvoidConflicts, '${fnName}', ${start}, ${end});
    throw e;
  } finally {
    Tracer.exitFunc(idWithExtensionToAvoidConflicts, '${fnName}', ${start}, ${end});
  }
}`;

const instrumentCode = (jsSourceCode) => {
  const output = falafel(jsSourceCode, (node) => {
    const parentType = node.parent && node.parent.type;
    const isBlockStatement = node.type === 'BlockStatement';
    const isFunctionBody = functionDefinitionTypes.includes(parentType);
    const isArrowFnReturnType = arrowFnImplicitReturnTypesRegex.test(node.type);
    const isArrowFunctionBody = parentType === 'ArrowFunctionExpression';
    const isArrowFn = node.type === 'ArrowFunctionExpression';

    if (isBlockStatement && isFunctionBody) {
      const { start, end } = node.parent;
      const fnName = (node.parent.id && node.parent.id.name) || 'anonymous';
      const block = node.source();
      const blockWithoutCurlies = block.substring(1, block.length - 1);
      node.update(traceBlock(blockWithoutCurlies, fnName, start, end));
    }
    else if (isArrowFnReturnType && isArrowFunctionBody) {
      const { start, end, params } = node.parent;
      const isParamIdentifier = params.some(param => param === node);
      if (!isParamIdentifier) {
        const fnName = (node.parent.id && node.parent.id.name) || 'anonymous';
        const block = node.source();
        const returnedBlock = `return (${block});`;
        node.update(traceBlock(returnedBlock, fnName, start, end));
      }
    }
    else if (isArrowFn) {
      const body = node.source();
      const firstCurly = body.indexOf('{');
      const lastCurly = body.lastIndexOf('}');
      const bodyHasCurlies = firstCurly !== -1 && lastCurly !== -1;
      if (bodyHasCurlies) {
        const parensNeedStripped = body[firstCurly - 1] === '(';
        if (parensNeedStripped) {
          const bodyBlock = body.substring(firstCurly, lastCurly + 1);
          const bodyWithoutParens = `() => ${bodyBlock}`;
          node.update(bodyWithoutParens);
        }
      }
    }
  });

  return babel.transformSync(output.toString(), { plugins: [traceLoops] }).code;
};

const nextId = (() => {
  let id = 0;
  return () => id++;
})();

const arrToPrettyStr = (arr) =>
  arr.map(a => _.isString(a) ? a : prettyFormat.format(a)).join(' ') + '\n';

const START_TIME = Date.now();
const TIMEOUT_MILLIS = 5000;
const EVENT_LIMIT = 500;

const Tracer = {
  enterFunc: (id, name, start, end) => postEvent(Events.EnterFunction(id, name, start, end)),
  exitFunc: (id, name, start, end) => postEvent(Events.ExitFunction(id, name, start, end)),
  errorFunc: (message, id, name, start, end) => postEvent(Events.ErrorFunction(message, id, name, start, end)),
  log: (...args) => postEvent(Events.ConsoleLog(arrToPrettyStr(args))),
  warn: (...args) => postEvent(Events.ConsoleWarn(arrToPrettyStr(args))),
  error: (...args) => postEvent(Events.ConsoleError(arrToPrettyStr(args))),
  iterateLoop: () => {
    const hasTimedOut = (Date.now() - START_TIME) > TIMEOUT_MILLIS;
    const reachedEventLimit = events.length >= EVENT_LIMIT;
    const shouldTerminate = reachedEventLimit || hasTimedOut;
    if (shouldTerminate) {
      postEvent(Events.EarlyTermination(hasTimedOut
        ? `Terminated early: Timeout of ${TIMEOUT_MILLIS} millis exceeded.`
        : `Terminated early: Event limit of ${EVENT_LIMIT} exceeded.`
      ));
      process.exit(1);
    }
  },
};

process.on('uncaughtException', (err) => {
  postEvent(Events.UncaughtError(err));
  process.exit(1);
});

const runInstrumentedCode = async (jsSourceCode) => {
  const instrumentedCode = instrumentCode(jsSourceCode);
  console.log('Original code:');
  console.log(jsSourceCode);
  console.log('Instrumented code:');
  console.log(instrumentedCode);

  // Dynamically import node-fetch
  const fetch = await import('node-fetch').then(module => module.default);

  const vm = new VM({
    timeout: 6000,
    sandbox: {
      nextId,
      Tracer,
      fetch,
      _,
      lodash: _,
      setTimeout,
      queueMicrotask,
      console: {
        log: Tracer.log,
        warn: Tracer.warn,
        error: Tracer.error,
      },
    },
  });

  vm.run(instrumentedCode);
};

const eventsReducer = (state, evt) => {
  const { type, payload } = evt;

  if (type === 'EarlyTermination') state.events.push(evt);
  if (type === 'UncaughtError') state.events.push(evt);

  if (type === 'ConsoleLog') state.events.push(evt);
  if (type === 'ConsoleWarn') state.events.push(evt);
  if (type === 'ConsoleError') state.events.push(evt);

  if (type === 'EnterFunction') {
    if (state.prevEvt.type === 'BeforePromise') {
      state.events.push({ type: 'DequeueMicrotask', payload: {} });
    }
    if (state.prevEvt.type === 'BeforeMicrotask') {
      state.events.push({ type: 'DequeueMicrotask', payload: {} });
    }
    state.events.push(evt);
  }
  if (type == 'ExitFunction') state.events.push(evt);
  if (type == 'ErrorFunction') state.events.push(evt);

  if (type === 'InitPromise') state.events.push(evt);
  if (type === 'ResolvePromise') {
    state.events.push(evt);

    const microtaskInfo = state.parentsIdsOfPromisesWithInvokedCallbacks
      .find(({ id }) => id === payload.id);

    if (microtaskInfo) {
      state.events.push({
        type: 'EnqueueMicrotask',
        payload: { name: microtaskInfo.name }
      });
    }
  }
  if (type === 'BeforePromise') state.events.push(evt);
  if (type === 'AfterPromise') state.events.push(evt);

  if (type === 'InitMicrotask') {
    state.events.push(evt);

    const microtaskInfo = state.parentsIdsOfMicrotasks
      .find(({ id }) => id === payload.id);

    if (microtaskInfo) {
      state.events.push({
        type: 'EnqueueMicrotask',
        payload: { name: microtaskInfo.name }
      });
    }
  }
  if (type === 'BeforeMicrotask') state.events.push(evt);
  if (type === 'AfterMicrotask') state.events.push(evt);

  if (type === 'InitTimeout') state.events.push(evt);
  if (type === 'BeforeTimeout') {
    state.events.push({ type: 'Rerender', payload: {} });
    state.events.push(evt);
  }

  state.prevEvt = evt;

  return state;
};

// TODO: Return line:column numbers for func calls

const reduceEvents = (events) => {
  // For some reason, certain Promises (e.g. from `fetch` calls) seem to
  // resolve multiple times. I don't know why this happens, but it screws things
  // up for the view layer, so we'll just take the last one ¯\_(ツ)_/¯
  events = _(events)
  .reverse()
  .uniqWith((aEvt, bEvt) =>
    aEvt.type === 'ResolvePromise' &&
    bEvt.type === 'ResolvePromise' &&
    aEvt.payload.id === bEvt.payload.id
  )
  .reverse()
  .value()

  // Before we reduce the events, we need to figure out when Microtasks
  // were enqueued.
  //
  // A Microtask was enqueued when its parent resolved iff the child Promise
  // of the parent had its callback invoked.
  //
  // A Promise has its callback invoked iff a function was entered immediately
  // after the Promise's `BeforePromise` event.

  const resolvedPromiseIds = events
    .filter(({ type }) => type === 'ResolvePromise')
    .map(({ payload: { id } }) => id);

  const promisesWithInvokedCallbacksInfo = events
    .filter(({ type }) =>
      ['BeforePromise', 'EnterFunction', 'ExitFunction', 'ResolvePromise'].includes(type)
    )
    .map((evt, idx, arr) =>
      evt.type === 'BeforePromise' && (arr[idx + 1] || {}).type === 'EnterFunction'
        ? [evt, arr[idx + 1]] : undefined
    )
    .filter(Boolean)
    .map(([beforePromiseEvt, enterFunctionEvt]) => ({
      id: beforePromiseEvt.payload.id,
      name: enterFunctionEvt.payload.name
    }))

  const promiseChildIdToParentId = {};
  events
    .filter(({ type }) => type === 'InitPromise')
    .forEach(({ payload: { id, parentId } }) => {
      promiseChildIdToParentId[id] = parentId;
    });

  const parentsIdsOfPromisesWithInvokedCallbacks = promisesWithInvokedCallbacksInfo
    .map(({ id: childId, name }) => ({
      id: promiseChildIdToParentId[childId],
      name,
    }));

  const microtasksWithInvokedCallbacksInfo = events
    .filter(({ type }) =>
      [ 'InitMicrotask', 'BeforeMicrotask', 'AfterMicrotask', 'EnterFunction', 'ExitFunction' ].includes(type)
    )
    .map((evt, idx, arr) =>
      evt.type === 'BeforeMicrotask' && (arr[idx + 1] || {}).type === 'EnterFunction'
        ? [evt, arr[idx + 1]] : undefined
    )
    .filter(Boolean)
    .map(([beforeMicrotaskEvt, enterFunctionEvt]) => ({
      id: beforeMicrotaskEvt.payload.id,
      name: enterFunctionEvt.payload.name
    }));

  const microtaskChildIdToParentId = {};
  events
    .filter(({ type }) => type === 'InitMicrotask')
    .forEach(({ payload: { id, parentId } }) => {
      microtaskChildIdToParentId[id] = parentId;
    });

  const parentsIdsOfMicrotasks = microtasksWithInvokedCallbacksInfo
    .map(({ id: childId, name }) => ({
      id: microtaskChildIdToParentId[childId],
      name,
    }));

  console.log({ resolvedPromiseIds, promisesWithInvokedCallbacksInfo, parentsIdsOfPromisesWithInvokedCallbacks, parentsIdsOfMicrotasks });

  return events.reduce(eventsReducer, {
    events: [],
    parentsIdsOfPromisesWithInvokedCallbacks,
    parentsIdsOfMicrotasks,
    prevEvt: {},
  }).events;
};

// Main execution
if (require.main === module) {
  const args = process.argv.slice(2);
  if (args.length !== 1) {
    console.error('Usage: node tracker.js <path_to_js_file>');
    process.exit(1);
  }

  const filePath = path.resolve(args[0]);
  try {
    const jsSourceCode = fs.readFileSync(filePath, 'utf8');
    runInstrumentedCode(jsSourceCode).catch(error => {
      console.error('Error running instrumented code:', error);
      process.exit(1);
    });
    const reducedEvents = reduceEvents(events);
    console.log(reducedEvents.map(JSON.stringify))
  } catch (error) {
    console.error('Error reading or processing the file:', error);
    process.exit(1);
  }
}
