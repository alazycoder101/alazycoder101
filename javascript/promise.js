console.log('Script start');

setTimeout(function () {
    console.log('setTimeout');
}, 0);

Promise.resolve().then(function () {
    console.log('promise1');
}).then(function () {
    console.log('promise2');
});

promise = new Promise(function (resolve, reject) {
    console.log('promise 1');
    resolve();
})
promise.then(function () {
    console.log('promise', 1, 1);
}).then(function () {
    console.log('promise', 1, 2);
}).then(function () {
    console.log('promise', 1, 3);
});
promise.then(function () {
    console.log('promise', 2, 1);
}).then(function () {
    console.log('promise', 2, 2);
}).then(function () {
    console.log('promise', 2, 3);
});
promise.then(function () {
    console.log('promise', 3, 1);
}).then(function () {
    console.log('promise', 3, 2);
}).then(function () {
    console.log('promise', 3, 3);
});
console.log('Script end');
