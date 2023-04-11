mod utils;
mod models;
mod schema;
mod controller;
mod repository;

use serde_json::json;
use http::ConnectionPool;
// fn main1() {
//     use self::schema::system_config::dsl::*;
    
//     let connection = &mut init_connection();
//     let results = system_config
//         .filter(id.eq(1))
//         .limit(5)
//         .load::<models::SystemConfig>(connection)
//         .expect("Error loading SystemConfig");

//     println!("Displaying {} system_config", results.len());
//     for config in results {
//         println!("{}", config.name);
//         println!("-----------\n");
//         println!("{}", config.value);
//     }
// }

use axum::{
    routing::post,
    Router,
    response::IntoResponse,
    http::StatusCode,
    Json
};

#[derive(Clone)]
pub struct ApplicationState(ConnectionPool);

pub struct ApplicationError(anyhow::Error);

impl IntoResponse for ApplicationError {
    fn into_response(self) -> axum::response::Response {
        let json = json!({ "message": format!("Something went wrong {}", self.0) });
        (StatusCode::INTERNAL_SERVER_ERROR, Json(json)).into_response()
    }
}

// allow use "?" in fn router
impl<E> From<E> for ApplicationError
where
    E: Into<anyhow::Error>,
{
    fn from(err: E) -> Self {
        Self(err.into())
    }
}


#[tokio::main]
async fn main() {
    let connection = http::init_connection();
    let app = Router::new()
        .route("/system", post(controller::system_config_controller::insert))
        .with_state(ApplicationState(connection));
    axum::Server::bind(&"0.0.0.0:3000".parse().unwrap())
        .serve(app.into_make_service()).await.unwrap();

}

