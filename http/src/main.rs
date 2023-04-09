#[macro_use] extern crate rocket;

use serde::{Deserialize, Serialize};

#[derive(Deserialize, Serialize, Debug)]
struct IpResponse {
    origin: String
}

#[get("/")]
fn index() -> &'static str {
    "Hello, world!"
}

#[launch]
fn rocket() -> _ {
    rocket::build().mount("/", routes![index])
}

// #[tokio::main]
// async fn main() -> Result<(), Box<dyn std::error::Error + Send + Sync>> {
//     let res = reqwest::get("http://httpbin.org/ip").await?
//         .json::<IpResponse>().await?;
//     println!("body: {:?}", res);
//
//     Ok(())
// }
