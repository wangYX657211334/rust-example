
use macro_example::my_custom_attribute;

#[my_custom_attribute]
struct S{}

#[test]
fn test_macro(){
// due to macro we have struct H in scope
    let demo=H{};
}