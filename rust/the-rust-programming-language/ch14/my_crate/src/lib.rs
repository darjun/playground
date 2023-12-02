//! # My Crate
//! 
//! my_crate 是一系列工具的集合，
//! 这些工具被用来简化特定的计算操作

/// 将传入的数字加1
/// 
/// # Examples
/// 
/// ```
/// let arg = 5;
/// let answer = my_crate::add_one(arg);
/// 
/// assert_eq!(6, answer);
/// ```
pub fn add_one(x: i32) -> i32 {
    x + 1
}