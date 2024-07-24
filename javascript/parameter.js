function double(x) {
    x = x * 2;
    console.log('inside double', x);
    return x;
}

let x = 2;
console.log('before double', x);
double(x);
console.log('after double', x);

function double_array(arr) {
    arr = arr.map(function (x) {
        console.log(x);
        return x * 2;
    });
    console.log('insdie', 'arr=', arr);
}

let arr = [1, 2];
double_array(arr);
console.log('arr=', arr);

function increase(obj) {
    obj.age += 1;
    console.log('inside increase', obj.age);
}
let person = new Object();
person.age = 20;
console.log('before increase', person.age);
increase(person)
console.log('after increase', person.age);
