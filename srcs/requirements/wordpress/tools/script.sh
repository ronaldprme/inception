#!/bin/bash

# Check if the wp-config.php file exists
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then

    # Download WordPress
    wp core download --allow-root

    # Configure WordPress
    wp core config \
        --dbname=$MARIADB_DATABASE \
        --dbuser=$MARIADB_USER \
        --dbpass=$MARIADB_PASSWORD \
        --dbhost=$MARIADB_ROOT_HOST \
        --dbprefix='wp_' \
        --dbcharset="utf8" \
        --dbcollate="utf8_general_ci" --allow-root

    # Install WordPress and create admin account, exclude from new user notification emails
    wp core install \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USR \
        --admin_password=$WP_ADMIN_PWD \
        --admin_email=$WP_ADMIN_EMAIL \
        --skip-email --allow-root

    # Create a WordPress user 
    wp user create $WP_USR $WP_EMAIL \
       --user_pass=$WP_PWD \
       --role=subscriber \
       --porcelain \
       --allow-root \
       --path=/var/www/wordpress


fi

# Start PHP-FPM
php-fpm7.4 --nodaemonize
