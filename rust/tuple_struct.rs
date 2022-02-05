// tuple_struct.rs
struct Color(u8, u8, u8);

fn main() {
    let white = Color(255, 255, 255); //可以通过索引访问它们
    let red = white.0;
    let green = white.1;
    let blue = white.2;

    println!("Red value: {}", red);
    println!("Green value: {}", green);
    println!("Blue value: {}\n", blue);
    let orange = Color(255, 165, 0); //你也可以直接解构字段
    let Color(r, g, b) = orange;
    println!("R: {}, G: {}, B: {} (orange)", r, g, b);
    //也可以在解构时忽略字段
    let Color(r, _, b) = orange;
}

