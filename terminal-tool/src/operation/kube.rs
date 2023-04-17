use std::fs;
use std::path::Path;
use std::io::{Result, ErrorKind};
use crate::operation::command::HOME_DIR;

pub fn kube_use(flag: &str)  -> Result<()> {

    let from_path_str = format!("{}/.kube/config-{}", *HOME_DIR, flag);
    let copy_from_path = Path::new(&from_path_str);
    if copy_from_path.try_exists()? {
        let to_path_str = format!("{}/.kube/config", *HOME_DIR);
        let copy_to_path = Path::new(&to_path_str);
        if copy_to_path.try_exists()? {
            fs::remove_file(copy_to_path)?;
        }
        fs::copy(copy_from_path, copy_to_path)?;
        println!("success use ~/.kube/config-{}", flag);
        Ok(())
    }else{
        eprintln!("not found ~/.kube/config-{}", flag);
        Err(ErrorKind::NotFound.into())
    }
}