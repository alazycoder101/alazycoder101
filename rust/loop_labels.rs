// loop_labels.rs
fn silly_sub(a: i32, b: i32) -> i32 {
    let mut result = 0;
    'increment: loop {
        if result == a {
            let mut dec = b;
            'decrement: loop {
                if dec == 0 {
                //直接从 'increment循环中断 break 'increment;
                } else {
                    result -= 1;
                    dec -= 1;
                }
            }
        } else {
        result += 1; }
    }
    result
}

fn main() {
    let a = 10;
    let b = 4;
    let result = silly_sub(a, b);
    println!("{} minus {} is {}", a, b, result);
}
