#[derive(Debug)] // 使我们能够打印并观察各州的设计
enum UsState {
    Alabama,
    Alaska,
    // --略--
}

enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter(UsState),
}

fn value_in_cents(coin: Coin) -> u32 {
    match coin {
        Coin::Penny => {
            println!("Lucky penny!");
            1
        },
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter(state) => {
            println!("State quarter from {:?}!", state);
            25
        },
    }
}

fn plus_one(x: Option<i32) -> Option<T> {
    match x {
        None => None,
        Some(i) => Some(i+1),
    }
}

let five = Some(5);
let six = plus_one(five);
let none = plus_one(None);