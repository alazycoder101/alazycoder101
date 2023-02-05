var i = 0;
function counter() {
    i = i + 1;
    console.log('up', i);
    postMessage(i);
    setTimeout("counter ()", 500);
}
counter();
