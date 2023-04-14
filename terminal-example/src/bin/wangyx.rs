use std::env;
use std::fs;
use std::path::Path;
use std::io::Result;


fn main() -> Result<()>{
    let home_dir = {
        match home::home_dir() {
            Some(path) => path.display().to_string(),
            None => panic!("Impossible to get your home dir!"),
        }
    };
    let args: Vec<String> = env::args().collect();
    let tool_name = &args[1];
    match tool_name.as_str() {
        "kubeuse" => {
            let mut from_path_str = home_dir.clone();
            from_path_str.push_str("/.kube/config-");
            from_path_str.push_str(&args[2]);
            let copy_from_path = Path::new(&from_path_str);
            if copy_from_path.try_exists()? {
                let mut to_path_str = home_dir.clone();
                to_path_str.push_str("/.kube/config");
                let copy_to_path = Path::new(&to_path_str);
                if copy_to_path.try_exists()? {
                    fs::remove_file(copy_to_path)?;
                }
                fs::copy(copy_from_path, copy_to_path)?;
                println!("success use ~/.kube/config-{}", &args[2]);
            }else{
                eprintln!("not found ~/.kube/config-{}", &args[2]);
            }
            Ok(())
        }
        _ => {
            eprintln!("unknow {}", &tool_name);
            Ok(())
        }
    }
}