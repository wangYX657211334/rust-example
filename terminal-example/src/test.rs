use std::{io::{stdout, Write}, thread, time::Duration};
use crossterm::{
    ExecutableCommand, QueueableCommand,
    terminal, cursor, style::{self, Stylize, Print}, Result
};


pub fn run1() -> Result<()> {
  let mut stdout = stdout();

  stdout.execute(terminal::Clear(terminal::ClearType::All))?;

  stdout
    .queue(cursor::MoveTo(10,10))?
    .queue(style::PrintStyledContent("test".dark_magenta()))?;
  stdout.flush()?;

  for y in 0..40 {
    for x in 0..150 {
      if (y == 0 || y == 40 - 1) || (x == 0 || x == 150 - 1) {
        // in this loop we are more efficient by not flushing the buffer.
        stdout
          .queue(cursor::MoveTo(x,y))?
          .queue(style::PrintStyledContent( "█".dark_magenta()))?;
        //   .queue(Print("foo 1\n".to_string()))?
        //   .queue(Print("foo 2\n".to_string()))?;
        thread::sleep(Duration::from_millis(10));
        stdout.flush()?;
      }
    }
  }
  Ok(())
}
