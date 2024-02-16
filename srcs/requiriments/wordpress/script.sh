#!/bin/bash

#instalar wp-cli

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar #descargar wp-cgi
php wp-cli.phar --info #comprobar que se ha descargado bien
chmod +x wp-cli.phar # darle permisos de ejecucion, por defecto no tiene
sudo mv wp-cli.phar /usr/local/bin/wp # mover a ubicación final

#Esto probablemente quitarlo, hacerlo con sed
mysql -u root -p #conectarse a mysql como root para crear nuevo usuario
CREATE USER username; #añadir usuario
CREATE DATABASE databasename default character set utf8 collate utf8_unicode_c default character set utf8 collate utf8_unicode_ci; #añadir base de datos
GRANT ALL PRIVILEGES ON databasename.* TO ‘username’ IDENTIFIED BY ‘yourpassword’; #conceder todos los permisos al usuario
FLUSH PRIVILIGES; #mandar privilegios
quit #salirse de mysql

#modificar wp-config.php con sed para introducir variables de entorno
sed -i -r "23s/database/$MDB_NAME/1"   wp-config.php
sed -i -r "26s/database_user/$MDB_USER/1"  wp-config.php
sed -i -r "29s/password/$MDB_PASSWORD/1"    wp-config.php
sed -i -r "32s/localhost/mariadb/1"    wp-config.php

wp core download .
wp config create --dbname=$MDB_NAME --dbuser=$MDBUSER --dbpass=$MDB_PASSWORD --dbhost=mariadb
wp db create
# installs WordPress and sets up the basic configuration for the site. The --url option specifies the URL of the site, --title sets the site's title, --admin_user and --admin_password set the username and password for the site's administrator account, and --admin_email sets the email address for the administrator. The --skip-email flag prevents WP-CLI from sending an email to the administrator with the login details.
wp core install --url=$DOMAIN_NAME/ --title=$TITLE --admin_user=$ADMIN_NAME--admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --skip-email --allow-root
# creates a new user account with the specified username, email address, and password. The --role option sets the user's role to author, which gives the user the ability to publish and manage their own posts.
wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
wp theme install astra --activate --allow-root
wp plugin install redis-cache --activate --allow-root

---------QUIZÁ OPCIONAL
# uses the sed command to modify the www.conf file in the /etc/php/7.3/fpm/pool.d directory. The s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g command substitutes the value 9000 for /run/php/php7.3-fpm.sock throughout the file. This changes the socket that PHP-FPM listens on from a Unix domain socket to a TCP port.
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf
# creates the /run/php directory, which is used by PHP-FPM to store Unix domain sockets.
mkdir /run/php
wp redis enable --allow-root
# starts the PHP-FPM service in the foreground. The -F flag tells PHP-FPM to run in the foreground, rather than as a daemon in the background.
/usr/sbin/php-fpm7.3 -F
