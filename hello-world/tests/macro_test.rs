
macro_rules! create_fn {
    ($fnName: ident, $value: expr) => {
        fn $fnName(){
            // println!("执行")
            println!("执行{}() -> {}", stringify!($fnName), $value)
        }
    };
}
macro_rules! item_test {
    ($i:item) => {
        $i
    };
}
macro_rules! block_test {
    ($b:block) => {
        fn b()$b
    };
}
#[test]
fn example() {
    create_fn!(test_fn, 1 + 5);
    test_fn();

    item_test!{
        #[derive(Debug)]
        struct A{
            _v: u8
        }
    }
    let a = A{_v: 1};
    println!("{:?}", a);

    block_test!({
        let a = 8u8;
        println!("{}", a);
    });
    b();
}