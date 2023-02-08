#![allow(unused)]
macro_rules! calculate {
    // (eval 1+2)
    (eval $e:expr) => {{
        {
            let val: usize = $e; // Force Types to be integers
            println!("{} = {}", stringify!{$e}, val);
        }
    }};
}


fn main() {
    calculate! {
        eval 1 + 2 // `eval` is _not_ a Rust keyword!
    }

    calculate! {
        eval (1 + 2) * (3 / 1)
    }
}
