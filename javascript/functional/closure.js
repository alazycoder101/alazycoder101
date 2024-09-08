function f(fn, x) {
    if (x < 1) {
        f(g, 1);
    } else {
        fn();
    }

    function g() {
        console.log(x);
    }
    return fn(x);
}

function h() {
}
f(h, 0);
