#!/bin/bash

# Setup users
mysql -uroot -ppassword -v << SQL
-- User for manage slave
CREATE USER IF NOT EXISTS 'slave'@'%' IDENTIFIED BY 'slave_password';
GRANT ALL PRIVILEGES ON *.* TO 'slave'@'%';
SQL