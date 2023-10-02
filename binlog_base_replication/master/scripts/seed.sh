#!/bin/bash

mysql -v << SQL 
USE test;

CREATE TABLE IF NOT EXISTS users (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO users (name) VALUES ('John'), ('Jane'), ('Bob'), ('Alice'), ('Eve');
SQL