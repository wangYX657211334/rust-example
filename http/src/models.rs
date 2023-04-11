use diesel::prelude::*;
use serde::{Deserialize, Serialize};
use crate::schema::system_config;

#[derive(Queryable, Deserialize, Serialize, Debug)]
#[diesel(table_name = system_config)]
pub struct SystemConfig {
    pub id: i32,
    pub name: String,
    pub value: String,
}

#[derive(Insertable, Deserialize, Serialize, Debug)]
#[diesel(table_name = system_config)]
pub struct CreateSystemConfig{
    pub name: String,
    pub value: String,
}