// for_loops.rs
fn main() { //不包括 10
    print!("Normal ranges: ");
    for i in 0..10 {
        print!("{},", i);
    }
    println!(); //另起一行 print!("Inclusive ranges: "); //开始计数直到 10
    for i in 0..=10 {
        print!("{},", i);
    }
}
