function getTimestamp() {
    return Date.now() + Math.random();
}
let id = 0;
function getId() {
    return id++;
}


class MyPromise {
    constructor(executor) {
        this.id = getId();
        console.log('constructor', this.id);
        // The initial state of the promise is 'pending'.
        this.state = 'pending';
        this.value = undefined;
        this.handlers = [];

        try {
            executor(this._resolve, this._reject);
        } catch (err) {
            this._reject(err);
        }
    }

    _resolve = (value) => {
        // Simulate async operation
        setTimeout(() => {
            if (this.state === 'pending') {
                this.state = 'fulfilled';
                this.value = value;
                this.handlers.forEach((h) => this._handle(h));
            }
        }, 0);
    }

    _reject = (error) => {
        setTimeout(() => {
            if (this.state === 'pending') {
                this.state = 'rejected';
                this.value = error;
                this.handlers.forEach((h) => this._handle(h));
            }
        }, 0);
    }

    _handle(handler) {
        console.log('handler', this.id, this.handlers.length);
        if (this.state === 'pending') {
            this.handlers.push(handler);
        } else {
            if (this.state === 'fulfilled' && typeof handler.onFulfilled === 'function') {
                handler.onFulfilled(this.value);
            }
            if (this.state === 'rejected' && typeof handler.onRejected === 'function') {
                handler.onRejected(this.value);
            }
        }
    }

    then(onFulfilled, onRejected) {
        console.log('then', this.id);
        return new MyPromise((resolve, reject) => {
            this._handle({
                onFulfilled: value => {
                    // Provide default handlers
                    if (!onFulfilled) {
                        resolve(value);
                    } else {
                        try {
                            resolve(onFulfilled(value));
                        } catch (err) {
                            reject(err);
                        }
                    }
                },
                onRejected: error => {
                    if (!onRejected) {
                        reject(error);
                    } else {
                        try {
                            resolve(onRejected(error));
                        } catch (err) {
                            reject(err);
                        }
                    }
                }
            });
        });
    }

    // You can also implement `catch` and `finally` methods...
}

// Usage example
const promise = new MyPromise((resolve, reject) => {
    setTimeout(() => {
        resolve('Resolved!');
        // reject(new Error('Rejected!'));
    }, 1000);
});

promise.then(value => console.log(value), error => console.error(error))
    .then(() => console.log('Chained promise', getId()))
    .then(() => console.log('Chained promise 2', getId()))
    .then(() => console.log('Chained promise 3', getId()));
