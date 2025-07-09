console.log('Script start');

setTimeout(function () {
    console.log('setTimeout', 0);
}, 0);

setTimeout(function () {
    console.log('setTimeout', 1);
    Promise.resolve().then(function () {
        setTimeout(function () {
            console.log('setTimeout', 'in', 'promise0', 'resolve');
        }, 0);
        console.log('promise0');
    }, 0);
});

new Promise(function (resolve, reject) {
    console.log('promise', 0);
    setTimeout(function () {
        console.log('setTimeout', 'in', 'promise', 'new');
        resolve();
    }, 0);
})

Promise.resolve().then(function () {
    setTimeout(function () {
        console.log('setTimeout', 'in', 'promise1');
    }, 0);
    console.log('promise1');
}).then(function () {
    setTimeout(function () {
        console.log('setTimeout', 'in', 'promise2');
    }, 0);
    console.log('promise2');
});

promise = new Promise(function (resolve, reject) {
    console.log('promise', 1);
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
});

promise3 = new Promise(function (resolve, reject) {
  console.log('promise3', 3, 1);
  Promise.resolve().then(function () {
    resolve();
    console.log('promise3', 3, 2);
  });
})

promise3.then(function () {
    console.log('promise3', 1, 1);
}).then(function () {
    console.log('promise3', 1, 2);
});
console.log('Script end');
