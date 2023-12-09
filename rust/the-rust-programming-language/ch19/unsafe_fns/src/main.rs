fn main() {
    println!("Hello, world!");
}

unsafe fn dangerous() {}

unsafe {
    dangerous();
}