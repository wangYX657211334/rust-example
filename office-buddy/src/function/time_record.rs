use std::collections::HashMap;
use crate::{AppError, AppState};
use axum::extract::{Path, Query, State};
use axum::http::StatusCode;
use axum::Json;
use axum::response::IntoResponse;
use chrono::NaiveDateTime;
use serde::{Deserialize, Serialize};
use serde_json::json;
use sqlx::{Execute, QueryBuilder};

#[derive(Serialize, Deserialize, Debug)]
pub struct TimeRecord {
    id: u64,
    time: Option<NaiveDateTime>,
    #[serde(rename = "motherFeeding")]
    mother_feeding: Option<i8>,
    #[serde(rename = "breastMilk")]
    breast_milk: Option<u8>,
    #[serde(rename = "powderedMilk")]
    powdered_milk: Option<u8>,
    #[serde(rename = "managementId")]
    management_id: Option<u64>,
}

pub async fn get(
    State(app): State<AppState>,
    Path(mId): Path<String>,
    Query(query): Query<HashMap<String, String>>,
) -> anyhow::Result<impl IntoResponse, AppError> {
    let row;
    if let Some(date) = query.get("date") {
        row = sqlx::query_as!(TimeRecord,
        r#"select
                id, time, mother_feeding, breast_milk, powdered_milk, management_id
               from time_record_model
               where deleted_at is null and management_id = ? and DATE_FORMAT(time,'%Y-%m-%d') = ?
               order by time desc
               "#, mId, date).fetch_all(&app.0).await?;
    } else {
        row = sqlx::query_as!(TimeRecord,
        r#"select
                id, time, mother_feeding, breast_milk, powdered_milk, management_id
               from time_record_model
               where deleted_at is null and management_id = ?
               order by time desc limit 9
               "#, mId).fetch_all(&app.0).await?;
    }
    if let Ok(json) = serde_json::to_string(&row) {
        Ok((StatusCode::OK, json))
    } else {
        Ok((StatusCode::OK, (&"[]").to_string()))
    }
}

pub async fn delete(
    State(app): State<AppState>,
    Path(id): Path<String>,
) -> anyhow::Result<impl IntoResponse, AppError> {
    let row = sqlx::query_as!(
        TimeRecord,
        r#"update time_record_model
           set deleted_at = now()
           where id = ?"#,
        id
    ).execute(&app.0).await?;
    Ok((StatusCode::OK, (&"{}").to_string()))
}

pub async fn insert(
    State(app): State<AppState>,
    Json(body): Json<TimeRecord>,
) -> anyhow::Result<impl IntoResponse, AppError> {
    let row = sqlx::query!(
        r#"insert into time_record_model(time, mother_feeding, breast_milk, powdered_milk, management_id, created_at, created_user)
           values (?, ?, ?, ?, ?, now(), 0)"#,
        body.time, body.mother_feeding, body.breast_milk, body.powdered_milk, body.management_id
    ).execute(&app.0).await?;
    Ok((StatusCode::OK, (&"{}").to_string()))
}
