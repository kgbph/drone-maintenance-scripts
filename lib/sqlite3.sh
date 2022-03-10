#!/bin/sh

sudo /usr/local/bin/sqlite3 /var/lib/drone/database.sqlite < $(dirname $0)/start.sql
