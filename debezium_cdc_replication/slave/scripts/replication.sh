#!/bin/bash

# Start replication
mysql -v << SQL
-- Setup replication configuration
STOP REPLICA;
RESET REPLICA;

CHANGE REPLICATION SOURCE TO
  SOURCE_SSL = 1,
  SOURCE_HOST = 'master',
  SOURCE_PORT = 3306,
  SOURCE_USER = 'repl',
  SOURCE_PASSWORD = 'repl_password',
  SOURCE_LOG_FILE = 'ON.000003',
  SOURCE_LOG_POS = 3729;

-- Start replication
START REPLICA;
SQL