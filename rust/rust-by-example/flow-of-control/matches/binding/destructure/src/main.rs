fn some_number() -> Option<i32> {
    Some(42)
}

fn main() {
    match some_number() {
        // Got `some` variant, match if its value, bound to `n`,
        // is equal to 42.
        Some(n @ 42) => println!("The answer: {}!", n),
        // Match any other number.
        Some(n) => println!("Not interesting... {}", n),
        // Match anything else (`None` variant).
        _ => (),
    }
}
