let str = 'a str';
const astr = 'a str';
var vstr = 'a str';

var vstr = 'a str'; // no problem
let str = 'a';    //Error

try {
  astr = 'b';       //Error
} catch (err) {
  console.log("astr = 'b'  " + err);
}
