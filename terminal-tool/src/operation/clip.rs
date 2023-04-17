use std::io::{self, Write, Result};
use std::fs;
use lazy_static::lazy_static;
use crate::operation::command::sh;
use crate::operation::command::HOME_DIR;
use clipboard_win::{formats, get_clipboard, set_clipboard};
use uuid::Uuid;

lazy_static! {
    static ref SYNC_FILE_HOME: String = {
        if HOME_DIR.contains("yuxin.wang") {
            format!("{}/office/vmcode/sync-file", *HOME_DIR)
        }else{
            format!("{}/office/code/sync-file", *HOME_DIR)
        }
    };
    static ref VERSION_PATH: String = format!("{}/clip/version.txt", *SYNC_FILE_HOME);
    static ref VALUE_PATH: String = format!("{}/clip/value", *SYNC_FILE_HOME);
    static ref TYPE_PATH: String = format!("{}/clip/type.txt", *SYNC_FILE_HOME);
}

pub fn clip_use(flag: &str)  -> Result<()> {
    match flag {
        "pull" => {
            let path = format!("{}/download.sh", *SYNC_FILE_HOME);
            sh!("sh", &path);
        }
        "pull-clip" => {
            clip_use("pull")?;
            let value = get_value();
            // 添加到剪贴板
            set_clip(&value);
            println!("\npull success, value: {}", value);
        }
        "push" => {
            let path = format!("{}/upload.sh", *SYNC_FILE_HOME);
            sh!("sh", &path);
        }
        "push-clip" => {
            let value = get_clip();
            set_value(&value);
            println!("\npush success, value: {}", value);
            clip_use("push")?;
        }
        "listen" => {
            let mut latest_version = String::new();
            let mut latest_value = String::new();
            let mut pull_size = 0;
            loop {
                clip_use("pull")?;
                pull_size += 1;
                let mut stdout = io::stdout();
                let log = format!("\rpull {} times, 'q' exit!", pull_size);
                stdout.write_all(log.as_bytes())?;
                stdout.flush()?;
                let version = get_version();
                if !latest_version.eq(&version) {
                    latest_version = version;
                    latest_value = get_value();
                    // 添加到剪贴板
                    set_clip(&latest_value);
                    println!("\npull success, value: {}", latest_value);
                }

                // 获取剪贴板
                let clip_value = get_clip();
                if clip_value.eq("q"){
                    std::process::exit(0);
                }
                if !latest_value.eq(&clip_value) {
                    set_value(&clip_value);
                    latest_version = set_version();
                    set_type("text");
                    latest_value = clip_value;
                    clip_use("push")?;
                    println!("\npush success, value: {}", latest_value);
                }
            }
        }
        _ => {

        }
    }

    Ok(())
}

fn get_version() -> String {
    fs::read_to_string(&VERSION_PATH.to_string()).expect("read ./clip/version.txt failed")
}

fn set_version() -> String {
    let version = Uuid::new_v4().to_string();
    fs::write(&VERSION_PATH.to_string(), &version).expect("write ./clip/version.txt failed");
    version
}

fn get_value() -> String {
    fs::read_to_string(&VALUE_PATH.to_string()).expect("read ./clip/value failed")
}
fn set_value(value: &str) {
    fs::write(&VALUE_PATH.to_string(), &value).expect("write ./clip/value failed");
}

fn set_type(type_name: &str) {
    fs::write(&TYPE_PATH.to_string(), &type_name).expect("write ./clip/type.txt failed");
}

fn set_clip(value: &str){
    set_clipboard(formats::Unicode, value).expect("write clipboard failed");
}

fn get_clip() -> String {
    get_clipboard(formats::Unicode).expect("read clipboard failed")
}