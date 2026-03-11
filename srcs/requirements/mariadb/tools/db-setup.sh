#!/bin/bash
set -e

MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mariadbd --user=mysql --datadir=/var/lib/mysql --skip-grant-tables --skip-networking --socket=/run/mysqld/mysqld.sock &

for i in $(seq 1 60); do
    if mysqladmin --socket=/run/mysqld/mysqld.sock ping --silent >/dev/null 2>&1; then
        break
    fi
    sleep 1
done

if ! mysqladmin --socket=/run/mysqld/mysqld.sock ping --silent >/dev/null 2>&1; then
    echo "MariaDB init failed: server not ready"
    exit 1
fi

mysql -u root <<EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DB}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

mysqladmin --socket=/run/mysqld/mysqld.sock -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

exec mariadbd --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0 --socket=/run/mysqld/mysqld.sock