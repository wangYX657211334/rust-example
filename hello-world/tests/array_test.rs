
fn print_array(array: &[i8]){
    println!("array: {:?}", array);
}

#[test]
fn array_test(){
    let array = [1,2,3,4,5];
    print_array(&array);
    print_array(&array[1..4]);
}