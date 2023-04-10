mod utils;
mod models;
mod schema;

use diesel::prelude::*;
use http::*;

fn main() {
    use self::schema::system_config::dsl::*;
    
    let connection = &mut establish_connection();
    let results = system_config
        .filter(id.eq(1))
        .limit(5)
        .load::<models::SystemConfig>(connection)
        .expect("Error loading SystemConfig");

    println!("Displaying {} system_config", results.len());
    for config in results {
        println!("{}", config.name);
        println!("-----------\n");
        println!("{}", config.value);
    }
}

// use axum::{
//     routing::get,
//     Router,
// };
// #[tokio::main]
// async fn main() {
//     let app = Router::new().route("/", get(|| async { "Hello, World!" }));
//     axum::Server::bind(&"0.0.0.0:3000".parse().unwrap())
//         .serve(app.into_make_service()).await.unwrap();

// }

