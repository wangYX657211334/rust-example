use crate::{models::SaveSystemConfig, repository::system_config_repository, AppError, AppState};
use axum::extract::Path;
use axum::{extract::State, http::StatusCode, response::IntoResponse, Json};

pub async fn insert(
    State(app): State<AppState>,
    Json(body): Json<SaveSystemConfig>,
) -> anyhow::Result<impl IntoResponse, AppError> {
    system_config_repository::insert(&mut app.0.get().unwrap(), body).await?;
    Ok(StatusCode::CREATED)
}

pub async fn update(
    State(app): State<AppState>,
    Path(id): Path<i32>,
    Json(body): Json<SaveSystemConfig>,
) -> anyhow::Result<impl IntoResponse, AppError> {
    system_config_repository::update(&mut app.0.get().unwrap(), id, body).await?;
    Ok(StatusCode::OK)
}

pub async fn delete(
    State(app): State<AppState>,
    Path(id): Path<i32>,
) -> anyhow::Result<impl IntoResponse, AppError> {
    system_config_repository::delete(&mut app.0.get().unwrap(), id).await?;
    Ok(StatusCode::OK)
}

pub async fn select_all(
    State(app): State<AppState>,
) -> anyhow::Result<impl IntoResponse, AppError> {
    let configs = system_config_repository::select_all(&mut app.0.get().unwrap()).await?;
    Ok((StatusCode::OK, Json(configs)))
}
