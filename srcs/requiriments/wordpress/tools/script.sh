#!/bin/bash

if [ ! -f /wordpress/wp-config.php ];
then
# create directory to use in nginx container later and also to setup the wordpress conf
mkdir /var/www/html

#instalar wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar #descargar wp-cgi
php wp-cli.phar --info #comprobar que se ha descargado bien
chmod +x wp-cli.phar # darle permisos de ejecucion, por defecto no tiene
mv wp-cli.phar /usr/local/bin/wp # mover a ubicación final

echo "WP-CLI SUCCESFULLY DOWNLOADED!"

wp core download --allow-root --path=/wordpress
wp config create --dbname=$MDB_DATABASE --dbuser=$MDB_USER --dbpass=$MDB_PASSWORD --dbhost=$MDB_HOST --path=/wordpress --allow-root 
#wp db create
# installs WordPress and sets up the basic configuration for the site. The --url option specifies the URL of the site, --title sets the site's title, --admin_user and --admin_password set the username and password for the site's administrator account, and --admin_email sets the email address for the administrator. The --skip-email flag prevents WP-CLI from sending an email to the administrator with the login details.
wp core install --url=$WP_DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_NAME--admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --path=/wordpress --allow-root 
# creates a new user account with the specified username, email address, and password. The --role option sets the user's role to author, which gives the user the ability to publish and manage their own posts.
wp user create $WP_USER_NAME $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PWD --path=/wordpress --allow-root 
wp theme install astra --activate --path=/wordpress --allow-root 
#wp plugin install redis-cache --activate --path=/wordpress
#wp redis enable --path=/wordpress
echo "WORDPRESS SUCCESFULLY INSTALLED!"
fi
# starts the PHP-FPM service in the foreground. The -F flag tells PHP-FPM to run in the foreground, rather than as a daemon in the background.
/usr/sbin/php-fpm7.3 -F
