use diesel::prelude::*;

#[derive(Queryable)]
pub struct SystemConfig {
    pub id: i32,
    pub name: String,
    pub value: String,
}