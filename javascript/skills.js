//https://wickedaf.medium.com/sharpen-your-javascript-skills-with-these-topics-63284a0ca813
//
// Exception
var x = 7, y = 7;
try {
  if(x == y){
    throw "errorOne";
  }else{
    throw "errorTwo";
  }
} catch(e) {
  if(e == "errorOne"){
   console.log("Same")
  }
  if(e == "errorTwo")
   console.log("Different")
}

// Destructing
const name = ['Shahriar', 'Emon'];
const [ firstName, lastName] = name;
console.log(firstName); //Shahriar
console.log(lastName); //Emon

// Arrow Function
//
// No parameters
var myFunc = () => {
    // Do stuff
};
// With parameters
var myFunc = (a, b) => {
    return a * b;
};
// Only 1 param, no need for parens
var myFunc = a => {
   return a * a;
 };
// No brackets and implicit return
// with single-line arrow function
var myFunc = a => a * a;
// Wrap body in parens to return
// object literal
var myFunc = (first, last) =>
 ({ firstName: first, lastName: last });


//Async
//
//Await
//
let a;
let b = 2;
a ??= 1;
console.log(a);
