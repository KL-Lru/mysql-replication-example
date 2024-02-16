#!/bin/bash

mysql -v << SQL 
USE test;

INSERT INTO users (id, name) VALUES (UUID(), 'John'), (UUID(), 'Jane'), (UUID(), 'Bob'), (UUID(), 'Alice'), (UUID(), 'Eve');

UPDATE users SET name = CONCAT(name, ' Doe') WHERE name = 'John' OR name = 'Jane';
SQL
