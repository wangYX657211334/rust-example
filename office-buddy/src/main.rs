mod function;
mod router;
mod utils;

use axum::{http::StatusCode, response::IntoResponse, Json};
use serde_json::json;

#[derive(Clone)]
pub struct AppState(office_buddy::ConnectionPool);

pub struct AppError(anyhow::Error);

impl IntoResponse for AppError {
    fn into_response(self) -> axum::response::Response {
        let json = json!({ "message": format!("Something went wrong {}", self.0) });
        (StatusCode::INTERNAL_SERVER_ERROR, Json(json)).into_response()
    }
}

// allow use "?" in fn router
impl<E> From<E> for AppError
where
    E: Into<anyhow::Error>,
{
    fn from(err: E) -> Self {
        Self(err.into())
    }
}

#[tokio::main]
async fn main() {
    let connection = office_buddy::init_connection().await;
    let app = router::root_router().with_state(AppState(connection));
    println!("server started! {}", "0.0.0.0:3000");
    axum::Server::bind(&"0.0.0.0:3000".parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();
}
