#!/bin/bash
set -e

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/credentials)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

until nc -z mariadb 3306; do
    echo "Waiting for MariaDB..."
    sleep 2
done

cd /var/www/html

if [ ! -f wp-config.php ]; then
    wp core download --allow-root

    wp config create \
        --allow-root \
        --dbname="$MYSQL_DB" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost=mariadb
    
    wp core install \
        --allow-root \
        --url="https://$DOMAIN_NAME" \
        --title="Inception" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"

    wp user create \
        --allow-root \
        "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author
fi

if ! wp plugin is-installed redis-cache --allow-root; then
    wp plugin install redis-cache --activate --allow-root
else
    wp plugin activate redis-cache --allow-root
fi

wp config set FS_METHOD direct --allow-root
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --raw --allow-root
wp redis enable --allow-root || true
chown -R www-data:www-data /var/www/html
exec php-fpm8.2 -F