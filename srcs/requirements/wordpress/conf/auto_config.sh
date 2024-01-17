#!/bin/bash

sleep 10

wp-cli.phar cli update --yes --allow-root
wp-cli.phar core download --allow-root


if [ ! -e /var/www/wordpress/wp-config.php ]; then
    wp-cli.phar config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path='/var/www/wordpress'

    sleep 2

    wp-cli.phar core install --allow-root \
    	--url=$DOMAIN_NAME \
        --title=$SITE_TITLE \
        --admin_user=$ADMIN_USER \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL \
        --path='/var/www/wordpress'

    wp-cli.phar user create --allow-root \
        --role=author $USER1_LOGIN $USER1_MAIL \
        --user_pass=$USER1_PASS \
        --path='/var/www/wordpress'
fi

if [ ! -d /run/php ]; then
    mkdir ./run/php
fi

/usr/sbin/php-fpm7.3 -F
