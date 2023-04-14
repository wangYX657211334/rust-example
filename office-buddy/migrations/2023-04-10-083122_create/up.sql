-- Your SQL goes here
CREATE TABLE system_config (
  id SERIAL PRIMARY KEY,
  group VARCHAR(32) NOT NULL,
  name VARCHAR(32) NOT NULL,
  value TEXT NOT NULL
)