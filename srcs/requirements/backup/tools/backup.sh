#!/bin/bash
set -e

DB_PASS=$(cat /run/secrets/db_password)
TS=$(date +"%Y%m%d_%H%M%S")
OUT_DIR=/backups
TMP_DB_FILE="$OUT_DIR/db_${TS}.sql.tmp"
DB_FILE="$OUT_DIR/db_${TS}.sql"
WP_FILE="$OUT_DIR/wp_${TS}.tar.gz"

mkdir -p "$OUT_DIR"

for _ in $(seq 1 60); do
	if mysqladmin -h mariadb -u"$MYSQL_USER" -p"$DB_PASS" ping --silent >/dev/null 2>&1; then
		break
	fi
	sleep 2
done

mysqladmin -h mariadb -u"$MYSQL_USER" -p"$DB_PASS" ping --silent >/dev/null 2>&1

mysqldump -h mariadb -u"$MYSQL_USER" -p"$DB_PASS" "$MYSQL_DB" > "$TMP_DB_FILE"
mv "$TMP_DB_FILE" "$DB_FILE"
tar -czf "$WP_FILE" -C /var/www/html .
find "$OUT_DIR" -type f -mtime +7 -delete
