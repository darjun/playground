#![allow(unreachable_code, unused_labels)]

fn main() {
    'outer: loop {
        println!("Entered the outer loop");

        'inner: loop {
            println!("Exiting the inner loop");

            break 'outer;
        }

        println!("This point will never be reached");
    }

    println!("Exited the outer loop");
}