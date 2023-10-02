#!/bin/bash

mysql -v << SQL 
SHOW REPLICA STATUS\G
SQL
