fn used_function() {}

#[allow(dead_code)]
fn unsued_function() {}

#[allow(dead_code)]
fn noisy_unused_function() {}

fn main() {
    used_function();
}