pub mod models;
pub mod schema;

use diesel::prelude::*;
use diesel::r2d2::ConnectionManager;
use diesel::r2d2::Pool;
use dotenvy;
use std::env;

pub type ConnectionPool = Pool<ConnectionManager<MysqlConnection>>;

pub fn init_connection() -> ConnectionPool {
    dotenvy::from_filename(".env.office").ok();
    // dotenvy::from_filename(".env.local").ok();

    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    let manager = ConnectionManager::<MysqlConnection>::new(&database_url);
    Pool::builder()
        .test_on_check_out(true)
        .build(manager)
        .unwrap_or_else(|_| panic!("Error connecting pool to {}", database_url))
}