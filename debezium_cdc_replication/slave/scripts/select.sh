#!/bin/bash

mysql -v << SQL
USE test;
SELECT * FROM users;
SQL