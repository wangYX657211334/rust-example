use std::env;
use std::io::{Result, ErrorKind};
use terminal_tool::operation::kube;
fn main() -> Result<()>{
    let args: Vec<String> = env::args().collect();
    let operation = &args[1];
    match operation.as_str() {
        "kube" => {
            kube::kube_use(&args[2])
        }
        _ => {
            eprintln!("unknow {}", &operation);
            Err(ErrorKind::NotFound.into())
        }
    }
}