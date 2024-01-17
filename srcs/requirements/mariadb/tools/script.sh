#!/bin/sh

# => Start mysql service
service mysql start;

# => Give a delay for a good service init
sleep 10

# => Change the password of the root user
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# => Create a database (if the database does not exist)
mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# => Create an user with a password (if the user does not exist)
mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# => Give all privileges to the user
mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# => Delete the user '' if exits
mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "DROP USER IF EXISTS ''@'localhost';"

# => Reload privileges after making changes
mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

# => Turn off the service
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# => Start mysql service safety mode
exec mysqld_safe
