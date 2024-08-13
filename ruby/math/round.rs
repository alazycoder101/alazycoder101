fn main() {
  let x = 2.675;
  println!("{:.2}", x);
  let y = (x * 100.0).round() / 100.0;
  println!("{:.2}", y);
}
