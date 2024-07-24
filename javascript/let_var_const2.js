let str = 'a str';
const astr = 'a str';
var vstr = 'a str';

var vstr = 'a str'; // no problem
try {
  let str = 'a';    //Error
} catch (err) {
  console.log("let str = 'a'  " + err);
}

try {
  astr = 'b';       //Error
} catch (err) {
  console.log("astr = 'b'  " + err);
}
