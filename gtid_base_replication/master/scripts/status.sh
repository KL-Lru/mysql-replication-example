#!/bin/bash

mysql -v << SQL 
SHOW MASTER STATUS\G
SQL
