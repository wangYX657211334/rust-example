use crate::{controller, AppState};
use axum::{
    routing::{post, put},
    Router,
};

pub fn root_router() -> Router<AppState> {
    Router::new()
        .route(
            "/system",
            post(controller::system_config_controller::insert)
                .get(controller::system_config_controller::select_all),
        )
        .route(
            "/system/:id",
            put(controller::system_config_controller::update)
                .delete(controller::system_config_controller::delete),
        )
}
