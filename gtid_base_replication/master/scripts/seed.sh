#!/bin/bash

mysql -v << SQL 
USE test;

CREATE TABLE IF NOT EXISTS users (
  id VARCHAR(36) NOT NULL,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO users (id, name) VALUES (UUID(), 'John'), (UUID(), 'Jane'), (UUID(), 'Bob'), (UUID(), 'Alice'), (UUID(), 'Eve');

UPDATE users SET name = CONCAT(name, ' Doe') WHERE name = 'John' OR name = 'Jane';
SQL