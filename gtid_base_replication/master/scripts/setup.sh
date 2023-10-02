#!/bin/bash

# Setup users
mysql -uroot -ppassword -v << SQL 
-- User for manage master
CREATE USER IF NOT EXISTS 'master'@'%' IDENTIFIED BY 'master_password';
GRANT ALL PRIVILEGES ON *.* TO 'master'@'%';

-- User for replication
CREATE USER IF NOT EXISTS 'repl'@'%' IDENTIFIED BY 'repl_password';
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';

-- User for PMM
CREATE USER IF NOT EXISTS 'pmm'@'%' IDENTIFIED BY 'pmm_password' WITH MAX_USER_CONNECTIONS 10;
GRANT SELECT, PROCESS, SUPER, REPLICATION CLIENT, RELOAD, BACKUP_ADMIN ON *.* TO 'pmm'@'%';
SQL