// variables.rs
fn main() {
    let target = "world";
    let mut greeting = "Hello"; // mut means mutable here
    println!("{}, {}", greeting, target);
    greeting = "How are you doing";
    target = "mate";
    println!("{}, {}", greeting, target);
}
