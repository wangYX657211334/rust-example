use crate::schema::system_config;
use diesel::prelude::*;
use serde::{Deserialize, Serialize};

#[derive(Queryable, Deserialize, Serialize, Debug)]
#[diesel(table_name = system_config)]
pub struct SystemConfig {
    pub id: i32,
    pub name: String,
    pub value: String,
}

#[derive(Insertable, AsChangeset, Deserialize, Serialize, Debug)]
#[diesel(table_name = system_config)]
pub struct SaveSystemConfig {
    pub name: String,
    pub value: String,
}
