
use global_hotkey::{GlobalHotKeyEvent, GlobalHotKeyManager, hotkey::{HotKey, Modifiers, Code}};

use winit::{
    event::{Event, WindowEvent},
    event_loop::{ControlFlow, EventLoop, EventLoopBuilder},
    platform::run_return::EventLoopExtRunReturn, // This is a trait used to enable returning values from run, which we'll use later
    window::{Window, WindowBuilder},
};

pub fn run(){
    let event_loop = EventLoopBuilder::new().build();
    // initialize the hotkeys manager
    let manager = GlobalHotKeyManager::new().unwrap();

    // construct the hotkeyC
    let hotkey = HotKey::new(Some(Modifiers::CONTROL), Code::KeyS);

    // register it
    manager.register(hotkey).unwrap();

    let global_hotkey_channel = GlobalHotKeyEvent::receiver();


    event_loop.run(move |_event, _, control_flow| {
        *control_flow = ControlFlow::Poll;

        if let Ok(event) = global_hotkey_channel.try_recv() {
            println!("{event:?} and {_event:?}");

            if hotkey.id() == event.id {
                // manager.unregister(hotkey).unwrap();
            }
        }
    })
}   


pub fn run2() {
    let mut event_loop = EventLoop::new();
    let window = WindowBuilder::new().build(&event_loop).unwrap();

    // Register hotkey
    window.set_title("Press Space Bar");
    println!("Press Space Bar");
    let hotkey = winit::event::VirtualKeyCode::G;

    event_loop.run_return(move |event, _, control_flow| {
        *control_flow = ControlFlow::Wait;
        println!("{event:?}");

        match event {
            Event::WindowEvent { event, .. } => match event {
                WindowEvent::KeyboardInput { input, .. } => {
                    println!("{input:?}");
                    if input.virtual_keycode == Some(hotkey) && input.state == winit::event::ElementState::Pressed {
                        // Hotkey pressed
                        window.set_title("Hotkey pressed!");
                        println!("Hotkey pressed!");
                        *control_flow = ControlFlow::ExitWithCode(0); // Exit the event loop when hotkey pressed
                    }
                }
                WindowEvent::CloseRequested => {
                    *control_flow = ControlFlow::ExitWithCode(1); // Exit the event loop when window closed
                }
                _ => (),
            },
            _ => (),
        }
    });
}