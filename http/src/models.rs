use diesel::prelude::*;

#[derive(Queryable)]
pub struct SystemConfig {
    pub id: i64,
    pub name: String,
    pub value: String,
}