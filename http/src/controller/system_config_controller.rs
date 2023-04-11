use axum::{Json, http::StatusCode, response::IntoResponse, extract::State};
use crate::{
    models::{
        CreateSystemConfig
    },
    repository::system_config_repository, 
    ApplicationState,
    ApplicationError,
};


pub async fn insert(State(app): State<ApplicationState>, Json(body): Json<CreateSystemConfig>) -> 
        anyhow::Result<impl IntoResponse, ApplicationError> {
    let mut connect = app.0.get().unwrap();
    system_config_repository::insert(&mut connect, body).await?;
    Ok(StatusCode::CREATED)
}