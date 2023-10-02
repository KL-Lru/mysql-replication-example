#!/bin/bash

# Setup users
mysql -uroot -ppassword -v << SQL
-- User for manage slave
CREATE USER IF NOT EXISTS 'slave'@'%' IDENTIFIED BY 'slave_password';
GRANT ALL PRIVILEGES ON *.* TO 'slave'@'%';

-- User for PMM
CREATE USER IF NOT EXISTS 'pmm'@'%' IDENTIFIED BY 'pmm_password' WITH MAX_USER_CONNECTIONS 10;
GRANT SELECT, PROCESS, SUPER, REPLICATION CLIENT, RELOAD, BACKUP_ADMIN ON *.* TO 'pmm'@'%';
SQL