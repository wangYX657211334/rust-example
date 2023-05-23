use crate::{function, AppState};
use axum::{
    routing::{delete, get, post},
    Router,
};

pub fn root_router() -> Router<AppState> {
    Router::new()
        .route(
            "/system/:key",
            post(function::system_config::save).get(function::system_config::get),
        )
        .route("/home/time/:id", delete(function::time_record::delete))
        .route("/home/time/list/:mId", get(function::time_record::get))
        .route("/home/time", post(function::time_record::insert))
}
