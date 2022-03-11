// mutable function
const addFruid = (array, fruit) => {
  array.push(fruit);
  return array;
};

const fruits = ['strawberry', 'apple', 'banana'];

console.log(addFruid(fruits, 'orange'));
console.log(fruits);

// pure function
const addFruidPure = (array, fruit) => [...array, fruit]

const fruits_pure = ['strawberry', 'apple', 'banana'];
console.log(addFruid(fruits_pure, 'orange'));
console.log(fruits_pure);
