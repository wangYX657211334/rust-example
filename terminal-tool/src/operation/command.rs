use lazy_static::lazy_static;

lazy_static! {
    pub static ref HOME_DIR: String = match dirs::home_dir() {
        Some(path) => path.to_str().unwrap().to_owned(),
        None => panic!("Failed to get home directory!"),
    };
}

#[macro_export]
macro_rules! sh {
    ($program:expr $(, $($arg:expr),*)?) => {
        {
            let mut temp_vec: Vec<&str> = Vec::new();
            $(
                $(
                    temp_vec.push($arg);
                )*
            )?
            let res = std::process::Command::new($program).args(&temp_vec).output();
            match res {
                Ok(output) => {
                    if !output.status.success() {
                        println!("execute command: {} {}", $program, temp_vec.join(" "));
                        println!("stderr: \n{}", String::from_utf8_lossy(&output.stderr));
                        std::process::exit(1);
                    }else{
                        format!("{}", String::from_utf8_lossy(&output.stdout))
                    }
                }
                Err(e) => {
                    println!("execute command: {} {}", $program, temp_vec.join(" "));
                    println!("err: \n{}", e);
                    std::process::exit(1);
                }
            }
        }
    };
}
pub(crate) use sh;

pub fn run() -> std::io::Result<()> {
    let out = sh!("git", "help", "-a");
    println!("{}", out);
    let out = sh!("cd", "~/office");
    println!("{}", out);
    let out = sh!("ls", "-l");
    println!("{}", out);

    Ok(())
}
