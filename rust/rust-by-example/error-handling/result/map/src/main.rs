use std::num::ParseIntError;

fn multiply(first_num_str: &str, second_num_str: &str) -> Result<i32, ParseIntError> {
    first_num_str.parse::<i32>().and_then(|first_number| {
        second_num_str.parse::<i32>().map(|second_number| first_number * second_number)
    })
}

fn print(result: Result<i32, ParseIntError>) {
    match result {
        Ok(n) => println!("n is {}", n),
        Err(e) => println!("Error: {}", e),
    }
}

fn main() {
    let twenty = multiply("10", "2");
    print(twenty);

    let tt = multiply("t", "2");
    print(tt);
}