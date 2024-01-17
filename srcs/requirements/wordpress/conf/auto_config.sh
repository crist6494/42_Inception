#!/bin/bash

# => Give a delay to wait mariadb configure right
sleep 10

# => update (with sudo) cli if is necessary
wp-cli.phar cli update --yes --allow-root
# => Downloads the core (main fails) of wordpress
wp-cli.phar core download --allow-root

# => Configure the database partner with mariadb 
if [ ! -e /var/www/wordpress/wp-config.php ]; then
    wp-cli.phar config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path='/var/www/wordpress'

    # => Give a delay to configure right
    sleep 2

    # => Install and configure the core (main fails) of wordpress
    wp-cli.phar core install --allow-root \
    	--url=$DOMAIN_NAME \
        --title=$SITE_TITLE \
        --admin_user=$ADMIN_USER \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL \
        --path='/var/www/wordpress'

    # => Create a user with cli
    wp-cli.phar user create --allow-root \
        --role=author $USER1_LOGIN $USER1_MAIL \
        --user_pass=$USER1_PASS \
        --path='/var/www/wordpress'
fi

# => Check if exist this directory,else creat taht is necesario for execute php
if [ ! -d /run/php ]; then
    mkdir ./run/php
fi

# =>Init the service php int first map
/usr/sbin/php-fpm7.3 -F
