use crate::{AppError, AppState};
use axum::extract::{Path, State};
use axum::http::StatusCode;
use axum::response::IntoResponse;
use sqlx::Row;

pub async fn save(
    State(app): State<AppState>,
    Path(key): Path<String>,
    body: String,
) -> anyhow::Result<impl IntoResponse, AppError> {
    let row =
        sqlx::query("update setting_model set value = ?, updated_at = now() where name = ? and `group` = 'Rust'")
            .bind(&body)
            .bind(&key)
            .execute(&app.0)
            .await?;
    if row.rows_affected() == 0 {
        sqlx::query("insert into setting_model (value, name, `group`, created_at) values (?, ?, 'Rust', now())")
            .bind(&body)
            .bind(&key)
            .execute(&app.0)
            .await?;
    }

    Ok(StatusCode::CREATED)
}

pub async fn get(
    State(app): State<AppState>,
    Path(key): Path<String>,
) -> anyhow::Result<impl IntoResponse, AppError> {
    let row = sqlx::query!(
        "select name, value from setting_model where name = ? and `group` = 'Rust'",
        key
    )
    .fetch_optional(&app.0)
    .await?;
    if let Some(o) = row {
        Ok((StatusCode::OK, o.value.unwrap_or(String::from("{}"))))
    } else {
        Ok((StatusCode::OK, String::from("{}")))
    }
}
