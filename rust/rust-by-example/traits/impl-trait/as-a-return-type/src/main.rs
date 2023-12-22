use std::iter;
use std::vec::IntoIter;

// This function combines two `Vec<i32>` and returns an iterator over it.
fn combine_vecs_explicit_return_type(
    v: Vec<i32>,
    u: Vec<i32>,
) -> iter::Cycle<iter::Chain<IntoIter<i32>, IntoIter<i32>>> {
    v.into_iter().chain(u.into_iter()).cycle()
}

// This is the exact same function, but its return type uses `impl Trait`.
fn combine_vecs(
    v: Vec<i32>,
    u: Vec<i32>,
) -> impl Iterator<Item=i32> {
    v.into_iter().chain(u.into_iter()).cycle()
}

fn main() {
    let v1 = vec![1, 2, 3];
    let v2 = vec![4, 5];
    let mut vec3 = combine_vecs(v1, v2);
    assert_eq!(Some(1), vec3.next());
    assert_eq!(Some(2), vec3.next());
    assert_eq!(Some(3), vec3.next());
    assert_eq!(Some(4), vec3.next());
    assert_eq!(Some(5), vec3.next());
    println!("all done");
}
