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
        this.finally_handlers = [];
        this.error;

        try {
            executor(this._resolve, this._reject);
        } catch (err) {
            this._reject(err);
            this._error(err);
        } finally {
            this.finally_handlers.forEach((h) => this._finally_handle(h));
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
                this.finally_handlers.forEach((h) => this._finally_handle(h));
            }
        }, 0);
    }

    _reject = (error) => {
        setTimeout(() => {
            if (this.state === 'pending') {
                this.state = 'rejected';
                this.value = error;
                this.handlers.forEach((h) => this._handle(h));
                this._error(error)
                this.finally_handlers.forEach((h) => this._finally_handle(h));
            }
        }, 0);
    }

    _error = (error) => {
        if (this.error) {
            this.error(error);
        }
    }

    _finally_handle(handler) {
        handler();
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
    // You can also implement `catch` and `finally` methods...
    catch(onError) {
        console.log('->then', this.id, this.state, 'handlers', this.handlers.length);
        this.error = onError;
        return this;
    }

    finally(onFinally) {
        this.finally_handlers.push(onFinally);
        return this;
    }
}

// Usage example
function checkMail() {
  return new MyPromise((resolve, reject) => {
    if (false &&Math.random() > 0.5) {
      resolve('Mail has arrived');
    } else {
      reject(new Error('Failed to arrive'));
    }
  });
}

checkMail()
  .then((mail) => {
    console.log(mail);
  })
  .catch((err) => {
    console.error(err);
  })
  .finally(() => {
    console.log('Experiment completed');
  });
