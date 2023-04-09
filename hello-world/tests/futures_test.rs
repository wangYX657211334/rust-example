// extern crate futures;

use futures::channel::mpsc;
use futures::{
    executor,
    executor::ThreadPool
};
use futures::StreamExt;

#[test]
fn future_test(){
    let pool = ThreadPool::new().expect("Failed to build ThreadPool");
    let (tx, rx) = mpsc::unbounded::<i32>();

    let future_values = async {
        let tx_values = async move {
            (0..100).for_each(|i| {
                tx.unbounded_send(i).expect("Failed to send")
            });
        };

        pool.spawn_ok(tx_values);

        let future_values = rx
            .map(|v| v * 2)
            .collect();
        // let future_values = rx.map(|v| v*2).collect();

        future_values.await
    };
    let values = executor::block_on(future_values);

    println!("value: {}", values);

}