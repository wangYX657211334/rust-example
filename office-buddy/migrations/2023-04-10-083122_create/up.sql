-- Your SQL goes here
CREATE TABLE system_config (
  id SERIAL PRIMARY KEY,
  name VARCHAR(32) NOT NULL,
  value TEXT NOT NULL
)