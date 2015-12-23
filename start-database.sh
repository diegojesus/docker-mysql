#!/bin/bash

# This script starts the database server.
echo "Creando el usuario $user para la base de datos desde la url $url"

# Import database if provided via 'docker run --env url="http:/ex.org/db.sql"'
echo "Añadiendo datos a MySQL"
/usr/sbin/mysqld &
sleep 5
curl $url -o import.sql

# Fixing some phpmysqladmin export problems
sed -ri.bak 's/-- Database: (.*?)/CREATE DATABASE \1;\nUSE \1;/g' import.sql

# Fixing some mysqldump export problems (when run without --databases switch)
# This is not tested so far
# if grep -q "CREATE DATABASE" import.sql; then :; else sed -ri.bak 's/-- MySQL dump/CREATE DATABASE `database_1`;\nUSE `database_1`;\n-- MySQL dump/g' import.sql; fi

mysql --default-character-set=utf8 < import.sql
rm import.sql
mysqladmin shutdown
echo "finished"

# Now the provided user credentials are added
/usr/sbin/mysqld &
sleep 5
echo "Creando usuario"
echo "CREATE USER '$user' IDENTIFIED BY '$password'" | mysql --default-character-set=utf8
echo "REVOKE ALL PRIVILEGES ON *.* FROM '$user'@'%'; FLUSH PRIVILEGES" | mysql --default-character-set=utf8
echo "GRANT SELECT ON *.* TO '$user'@'%'; FLUSH PRIVILEGES" | mysql --default-character-set=utf8
echo "Finalizado"

if [ "$right" = "WRITE" ]; then
echo "añadiendo permisos al usuario"
echo "GRANT ALL PRIVILEGES ON *.* TO '$user'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql --default-character-set=utf8
fi

# And we restart the server to go operational
mysqladmin shutdown
echo "Iniciando MySQL Server"
/usr/sbin/mysqld