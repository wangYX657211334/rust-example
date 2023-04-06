extern crate tui;

use std::{
    io::{self, stdout}, 
    thread,
    time::Duration
};
use crossterm::{execute, style::Print};
// use tui::{backend::CrosstermBackend, Terminal};

// fn main1() -> Result<(), io::Error> {
//     let stdout = io::stdout();
//     let backend = CrosstermBackend::new(stdout);
//     let mut terminal = Terminal::new(backend)?;
//     println!("success!");
//     Ok(())
// }

fn main() -> io::Result<()> {
    for i in 1..=50 {
        execute!(stdout(), Print("[".to_string()))?;
        for _ in 1..=i{
            execute!(stdout(), Print("1".to_string()))?;
        }
        for _ in i..50{
            execute!(stdout(), Print("0".to_string()))?;
        }
        execute!(stdout(), Print(format!("] {}%\r", i*2).to_string()))?;
        thread::sleep(Duration::from_millis(100));
    }
    execute!(stdout(), Print("\ndone!\n".to_string()))?;
    thread::sleep(Duration::from_millis(100));
    // execute!(stdout(), Print("\x1B[2K\ra\n".to_string()))?;
    Ok(())
}