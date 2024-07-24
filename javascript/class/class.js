class Father {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }
    sum() {
        return this.x + this.y;
    }
}

class Son extends Father {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }
}

son = new Son(1, 2);
console.log(son.x, son.y);

console.log('sum=', son.sum());
