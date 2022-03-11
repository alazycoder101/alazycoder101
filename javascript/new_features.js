// https://javascript.plainenglish.io/javascript-2021-new-features-429bc050f4e8
let a = 1;
let b = 2;
a &&= b;
a ||= b;
console.log(b); // output for variable 'a' would be 1.

a = null
a ??= 1;
console.log(a) // output for variable 'a' would be 1.
// this code block is similar to the code given above.
// if(!a) {
//   a = 1
// }


//replaceAll
let str = 'JS is everywhere. JS is amazing!';
console.log(str.replaceAll('JS', 'JavaScript')); // the output would be 'JavaScript is everywhere. JavaScript is amazing!'.

//underscore
let number = 1_000_000_000; // one billion
console.log(number) // 1000000000 (the number would remain an integer)

const p1 = new Promise(resolve => setTimeout(resolve, 500, 'First'));
const p2 = new Promise(resolve => setTimeout(resolve, 800, 'Second'));
const p3 = Promsie.reject(1);
const promises = [p1, p2, p3];
Promise.any(promises)
.then(result => {
   console.log(result);
}) // the result would be 'First' because that's the promise, that is fulfilled first.
.catch(e => {
    console.log(e);
})

// WeakRef and Finalizers
const weakRefFunc = () => {
    const obj = new WeakRef({
       name: 'JavaScript'
    });
    console.log(obj.deref().name);
}
const test = () => {
    new Promise(resolve => {
     setTimeout(() => {
       weakRefFunc();
        resolve();
      }, 3000)
    })
    new Promise(resolve => {
     setTimeout(() => {
       weakRefFunc();
        resolve();
      }, 5000)
    })
}
test();

// Finalizers
const registerFinalizer = new FinalizationRegistry(data => console.log(data));
const obj = {'name': 'JavaScript'};
registerFinalizer.register(obj, 'obj is collected now!')
