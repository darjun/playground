fn main() {
    let my_string = String::from("hello world");
    // first_word 可以接收 String 对象的切片作为参数
    let word = first_word(&my_string[..]);

    let my_string_literal = "hello world";

    // first_word 可以接收字符串字面量的切片作为参数
    let word = first_word(&my_string_literal[..]);

    // 由于字符串字面量本身就是切片，所以我们可以在这里将它传入函数，
    // 而不需要使用额外的切片语法！
    let word = first_word(my_string_literal);
}

fn first_word(s: &str) -> &str {
    let bytes = s.as_bytes();

    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }

    &s[..]
}
