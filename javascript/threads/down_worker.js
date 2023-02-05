var i = 1000;
function counter() {
    i = i - 1;
    console.log('down', i);
    postMessage(i);
    setTimeout("counter ()", 200);
}
counter();
