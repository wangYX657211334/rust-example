use std::fs;
use std::io::Result;

pub fn read(path: &str) -> Result<String> {
    fs::read_to_string(path)
}