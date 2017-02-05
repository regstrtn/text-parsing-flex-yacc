#!/bin/bash

python3 crawl1.py
make
python3 runparser.py
rm ./databaseinp/.csv
python insertdb.py
/Applications/XAMPP/xamppfiles/bin/mysql -u root faculty < createtable.sql
/Applications/XAMPP/xamppfiles/bin/mysql -u root faculty < query.sql