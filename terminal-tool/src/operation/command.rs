use std::process::{self, Command};

macro_rules! sh {
    ($program:expr $(, $($arg:expr),*)?) => {
        {
            let mut temp_vec: Vec<&str> = Vec::new();
            $(
                $(
                    temp_vec.push($arg);
                )*
            )?
            let res = Command::new($program).args(&temp_vec).output();
            let out = match res {
                Ok(output) => {
                    if !output.status.success() {
                        println!("execute command: {} {}", $program, temp_vec.join(" "));
                        println!("stderr: \n{}", String::from_utf8_lossy(&output.stderr));
                        process::exit(1);
                    }else{
                        format!("{}", String::from_utf8_lossy(&output.stdout))
                    }
                }
                Err(e) => {
                    println!("execute command: {} {}", $program, temp_vec.join(" "));
                    println!("err: \n{}", e);
                    process::exit(1);
                }
            };
            out
        }
    };
}

pub fn run() -> std::io::Result<()> {
    let out = sh!("git", "help", "-a");
    println!("{}", out);
    let out = sh!("pwdd", "aa", "-d");
    println!("{}", out);

    Ok(())
}
