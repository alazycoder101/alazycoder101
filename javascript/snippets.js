// https://thesmartcoder.dev/10-javascript-code-snippets-you-can-use-right-now/

// 1. Reverse a String
const reverseString = string => [...string].reverse().join('')

// EXAMPLES
reverseString('Medium'); // 'muideM'
reverseString('Better Programming');

// 2. Calculate a Number's Factorial
const factorialOfNumber = number =>
  number < 0
    ? (() => {
      throw new TypeError('No negative numbers please');
    })()
    : number <= 1
      ? 1
      : number * factorialOfNumber(number - 1)

//EXAMPLES
factorialOfNumber(4);
factorialOfNumber(8);

// 3. Convert a Number to an Array of Digits
const convertToArray= number => [...`${number}`].map(el => parseInt(el));

// EXAMPLES
convertToArray(5678);
convertToArray(123456789);

// 4. Check if a Number Is a Power of Two
const isNumberPowerOfTwo = number => !!number && (number & (number - 1)
) == 0;

// EXAMPLES
isNumberPowerOfTwo(100);
isNumberPowerOfTwo(128);

// 5. Create an Array of Key-Value Pairs From an Object
const keyValuePairsToArray = object => Object.keys(object).map(el => [el, object[el]]);

// EXAMPLES
keyValuePairsToArray({ Better: 4, Programming: 2});
keyValuePairsToArray({ x: 1, y: 2, z: 3});

// 6. Return [Number] Maximum Elements From an Array
const maxElementsFromArray = (array, number = 1) => [...array].sort((x, y) => y - x).slice(0, number);

maxElementsFromArray([1, 2, 3, 4, 5]);
maxElementsFromArray([7, 8, 9, 10, 10], 2);


// 7. Check if All Elements in an Array Are Equal
const elementsAreEqual = array => array.every(el => el === array[0]);

elementsAreEqual([9, 8, 7, 6, 5]);

// 8 Rturn the Average of Two Numbers
const averageOfTwoNumbers = (...numbers) => numbers.reduce((accumulator, currentValue) => accumulator + currentValue, 0) / numbers.length;

// 9. Return the sum of Two or More Numbers
const sumOfNumbers = (...numbers) => numbers.reduce((accumulator, currentValue) => accumulator + currentValue, 0);

// 10. Return the Powerset of an Array of Numbers
const powersetOfArray = array => array.reduce((accumulator, currentValue) => accumulator.concat(accumulator.map(el => [currentValue].concat(el))), [[]]);

powersetOfArray([4, 2]);
