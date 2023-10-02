#!/bin/bash

# Setup users
mysql -uroot -ppassword -v << SQL 
-- User for manage master
CREATE USER IF NOT EXISTS 'master'@'%' IDENTIFIED BY 'master_password';
GRANT ALL PRIVILEGES ON *.* TO 'master'@'%';
SQL

mysql -v << SQL 
USE test;

CREATE TABLE IF NOT EXISTS users (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
SQL