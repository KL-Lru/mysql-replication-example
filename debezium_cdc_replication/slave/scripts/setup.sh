#!/bin/bash

# Setup users
mysql -uroot -ppassword -v << SQL
-- User for manage slave
CREATE USER IF NOT EXISTS 'slave'@'%' IDENTIFIED BY 'slave_password';
GRANT ALL PRIVILEGES ON *.* TO 'slave'@'%';
SQL

mysql -v << SQL 
USE test;

CREATE TABLE IF NOT EXISTS users (
  id VARCHAR(36) NOT NULL,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
SQL