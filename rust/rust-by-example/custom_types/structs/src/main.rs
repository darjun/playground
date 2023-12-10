#![allow(dead_code)]

#[derive(Debug)]
struct Person {
    name: String,
    age: u8,
}

struct Unit;

struct Pair(i32, f32);

#[derive(Debug)]
struct Point {
    x: f32,
    y: f32,
}

#[derive(Debug)]
struct Rectangle {
    top_left: Point,
    bottom_right: Point,
}

fn main() {
    let name = String::from("Peter");
    let age = 27;
    let peter = Person { name, age };

    println!("{:?}", peter);

    let point: Point = Point { x: 10.3, y: 0.4 };

    println!("point coordinates: ({}, {})", point.x, point.y);

    let bottom_right = Point { x: 5.2, ..point };

    println!("second point: ({}, {})", bottom_right.x, bottom_right.y);

    let Point { x: left_edge, y: top_edge } = point;

    let rectangle = Rectangle {
        top_left: Point { x: left_edge, y: top_edge },
        bottom_right: bottom_right,
    };

    let _unit = Unit;

    let pair = Pair(1, 0.1);

    println!("pair contains {:?} and {:?}", pair.0, pair.1);

    let Pair(integer, decimal) = pair;

    println!("pair contains {:?} and {:?}", integer, decimal);

    println!("rectange area is {}", rect_area(rectangle));

    println!("new rectangle is {:?}", square(point, 10f32));
}

fn rect_area(Rectangle{ top_left: Point { x: left_edge, y: top_edge }, bottom_right: Point { x: right_edge, y: bottom_edge }}: Rectangle) -> f32 {
    (right_edge - left_edge) * (bottom_edge - top_edge)
}

fn square(top_left: Point, size: f32) -> Rectangle {
    let Point { x: left_edge, y: top_edge } = top_left;
    Rectangle {
        top_left,
        bottom_right: Point { x: left_edge + size, y: top_edge + size },
    }
}