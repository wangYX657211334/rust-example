use axum::{Json, http::StatusCode, response::{Response, IntoResponse}, extract::State};
use crate::{
    models::{
        CreateSystemConfig
    },
    repository::system_config_repository, 
    ApplicationState,
    ApplicationError,
};


pub async fn insert(State(app): State<ApplicationState>, Json(body): Json<CreateSystemConfig>) -> 
        anyhow::Result<Response, ApplicationError> {
    let mut connect = app.0.get().unwrap();
    system_config_repository::insert(&mut connect, body).await?;
    let res = StatusCode::CREATED.into_response();
    Ok(StatusCode::CREATED.into_response())
}