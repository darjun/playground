fn main() {
    struct Foo {
        x: (u32, u32),
        y: u32,
    }

    let foo = Foo { x: (1, 2), y: 3 };

    match foo {
        Foo { x: (1, b), y } => println!("First of x is 1, b = {}, y = {}", b, y),

        Foo { y: 2, x: i } => println!("y is 2, i = {:?}", i),

        Foo { y, .. } => println!("y = {}, we don't care about x", y),
    }

    let faa = Foo { x: (1, 2), y: 3 };

    let Foo { x: x0, y: y0 } = faa;
    println!("Outside: x0 = {x0:?}, y0 = {y0}");
}