use std::{process::{self, Command}};

macro_rules! sh {
    (
        $program:expr, $($arg:expr),* 
    ) => {
        let mut temp_vec: Vec<String> = Vec::new();
        $(
            temp_vec.push($arg);
        )*
        let res = Command::new($program).args(temp_vec).output();
        match res {
            Ok(output) => {
                if !output.status.success() {
                    println!("command: {} {}", $program, temp_vec.join(" "));
                    println!("stderr: \n{}", String::from_utf8_lossy(&output.stderr));
                    process::exit(1);
                }else{
                    println!("stdout: {}", String::from_utf8_lossy(&output.stdout));
                }
            }
            Err(e) => {
                println!("command: {} {}", $program, temp_vec.join(" "));
                println!("err: \n{}", e);
                process::exit(1);
            }
        }
    };
}

pub fn run() -> std::io::Result<()>{
    sh!("pwd".to_string(), );
    sh!("git".to_string(), );
    let test = vec!["a".to_string(), "b".to_string()];

    println!(test.join(" "));

    // let output = Command::new("pwd").output()?;
    // println!("run: pwd");
    // println!("status: {}", output.status);
    // println!("stdout: {}", String::from_utf8_lossy(&output.stdout));
    // println!("stderr: {}", String::from_utf8_lossy(&output.stderr));
    // let res = Command::new("git").args(["help", "-a"]).output();
    // match res {
    //     Ok(output) => {
    //         if !output.status.success() {
    //             println!("command: {} {}", "git", ["help", "-a"].join(" "));
    //             println!("stderr: \n{}", String::from_utf8_lossy(&output.stderr));
    //             process::exit(1);
    //         }else{
    //             String::from_utf8_lossy(&output.stdout).to_string();
    //         }
    //     }
    //     Err(e) => {
    //         println!("command: {} {}", "git", ["help", "-a"].join(" "));
    //         println!("err: \n{}", e);
    //         process::exit(1);
    //     }
    // }
    
    
    Ok(())
}
