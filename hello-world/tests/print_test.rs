use std::fmt::{Debug, Formatter, write};
use std::fmt::Display;

#[test]
fn print_test(){
    println!("普通占位: {}, {}", 30i8, "abc");

    println!("下标占位: 0:{0}, 1:{1}, 0:{0}", "a", "b");

    println!("参数名占位: a:{a}, b:{b}, a:{a}", a=18i8, b="char");

    println!("二进制输出: {:b}", 255u8);

    println!("{value:>prefixSize$}", prefixSize=8, value=1);
    println!("{value:>0prefixSize$}", prefixSize=8, value=1);

    #[derive(Debug)]
    struct Structure(i32);

    impl Display for Structure{
        fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
            write!(f, "Structure{{0: {}}}", self.0)
        }
    }
    let s = Structure(3);
    println!("Display: {0}, Debug: {0:#?} ", s);
}