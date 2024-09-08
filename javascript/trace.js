function a() {
    b();
}
function b() {
    c();
}
function c() {
    console.trace();
}

const async_hooks = require('async_hooks');

const hook = async_hooks.createHook({
    init(asyncId, type, triggerAsyncId, resource) {
        console.log('Initialization {asyncId: %d, type: "%s"}', asyncId, type);
    },
    before(asyncId) {
        console.log('Before {asyncId: %d}', asyncId);
    },
    after(asyncId) {
        console.log('After {asyncId: %d}', asyncId);
    },
    destroy(asyncId) {
        console.log('Destroy {asyncId: %d}', asyncId);
    },
});

hook.enable();
a();
