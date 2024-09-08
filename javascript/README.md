```bash
node --trace-uncaught trace.js
```

```bash
node --trace-event-categories node.promises,node.timer trace.js

node --trace-event-categories node --trace-warnings your-script.js
```

1. Open Chrome and input `chrome://tracing` in the address bar.
2. load the trace file in Chrome.
3. analyze the trace file in Chrome.



```js
const trace_events = require('trace_events');
const tracing = trace_events.createTracing({ categories: ['node.promises', 'node.timer'] });
tracing.enable();
// 执行你的代码
tracing.disable();
```



