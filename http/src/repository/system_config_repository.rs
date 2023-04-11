use crate::models::{SaveSystemConfig, SystemConfig};
use diesel::{prelude::MysqlConnection, ExpressionMethods, RunQueryDsl};

pub async fn insert(conn: &mut MysqlConnection, body: SaveSystemConfig) -> anyhow::Result<()> {
    diesel::insert_into(crate::schema::system_config::table)
        .values(&body)
        .execute(conn)?;
    Ok(())
}

pub async fn update(
    conn: &mut MysqlConnection,
    id: i32,
    body: SaveSystemConfig,
) -> anyhow::Result<()> {
    diesel::update(crate::schema::system_config::table)
        .filter(crate::schema::system_config::id.eq(id))
        .set(&body)
        .execute(conn)?;
    Ok(())
}

pub async fn delete(conn: &mut MysqlConnection, id: i32) -> anyhow::Result<()> {
    diesel::delete(crate::schema::system_config::table)
        .filter(crate::schema::system_config::id.eq(id))
        .execute(conn)?;
    Ok(())
}

pub async fn select_all(conn: &mut MysqlConnection) -> anyhow::Result<Vec<SystemConfig>> {
    use http::schema::system_config::dsl::*;
    Ok(system_config.load::<SystemConfig>(conn)?)
}
