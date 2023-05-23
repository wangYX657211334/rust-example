use dotenvy;
use sqlx::{MySql, MySqlPool, Pool};
use std::env;

pub type ConnectionPool = Pool<MySql>;

pub async fn init_connection() -> ConnectionPool {
    dotenvy::dotenv().ok();
    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    let pool = MySqlPool::connect(&database_url).await;
    return pool.unwrap();
}
