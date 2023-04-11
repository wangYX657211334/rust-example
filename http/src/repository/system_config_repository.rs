
use diesel::{prelude::MysqlConnection, RunQueryDsl};
use crate::{
    models::{
        CreateSystemConfig
    },
    schema::system_config
};

pub async fn insert(conn: &mut MysqlConnection, config: CreateSystemConfig) -> anyhow::Result<()>{

    diesel::insert_into(system_config::table)
        .values(&config).execute(conn)?;

    Ok(())
}