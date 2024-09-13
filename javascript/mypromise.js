function getTimestamp() {
    return Date.now() + Math.random();
}
let id = 1;
function getId() {
    return id++;
}

class MyPromise {
    constructor(executor) {
        this.id = getId();
        console.log('->constructor', this.id);
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
            console.log('->_resolve', this.id, 'handlers', this.handlers.length);
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
        if (this.state === 'pending') {
            this.handlers.push(handler);
            console.log('->_handler', this.id, 'handlers', this.handlers.length);
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
        console.log('->then', this.id, this.state, 'handlers', this.handlers.length);
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

    catch(onRejected) {
        return this.then(null, onRejected);
    }

    finally(onFinally) {
        return this.then(
            value => {
                onFinally();
                return value;
            },
            reason => {
                onFinally();
                throw reason;
            }
        );
    }
}

// Usage example
const promise = new MyPromise((resolve, reject) => {
    setTimeout(() => {
        resolve('Resolved!');
        // reject(new Error('Rejected!'));
    }, 10);
});

promise.then(value => console.log(1, 0, value), error => console.error(error))
    .then(() => console.log(1, 1, 'Chained promise'))
    .then(() => console.log(1, 2, 'Chained promise'))
    .then(() => console.log(1, 3, 'Chained promise'));
promise.then(value => console.log(2, 0, value), error => console.error(error))
    .then(() => console.log(2, 1, 'Chained promise'))
    .then(() => console.log(2, 2, 'Chained promise'));
promise.then(value => console.log(3, 0, value), error => console.error(error))
    .then(() => console.log(3, 1, 'Chained promise'));
promise.then(value => console.log(4, 0, value), error => console.error(error));

promise
    .then(value => console.log('Fulfilled:', value))
    .catch(error => console.error('Caught:', error))
    .finally(() => console.log('Finally: This runs regardless of the outcome'));
