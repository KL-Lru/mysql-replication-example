#!/bin/bash

mysql -v << SQL 
USE test;

INSERT INTO users (name) VALUES ('John'), ('Jane'), ('Bob'), ('Alice'), ('Eve');
SQL