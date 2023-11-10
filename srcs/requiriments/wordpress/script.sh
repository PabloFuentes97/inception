#!/bin/bash

#instalar wp-cli

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar #descargar wp-cgi
php wp-cli.phar --info #comprobar que se ha descargado bien
chmod +x wp-cli.phar # darle permisos de ejecucion, por defecto no tiene
sudo mv wp-cli.phar /usr/local/bin/wp # mover a ubicación final

#instalar wordpress con cli
mysql -u root -p #conectarse a mysql como root para crear nuevo usuario
CREATE USER username; #añadir usuario
CREATE DATABASE databasename default character set utf8 collate utf8_unicode_c default character set utf8 collate utf8_unicode_ci; #añadir base de datos
GRANT ALL PRIVILEGES ON databasename.* TO ‘username’ IDENTIFIED BY ‘yourpassword’; #conceder todos los permisos al usuario
FLUSH PRIVILIGES; #mandar privilegio
FLUSH PRIVILIGES; #mandar privilegios
quit #salirse de mysql
cd /home/username/public_html #moverse a directorio public_html, donde están guardados archivos del sitio web
wp core install #descargar wordpress
wp core config --dbname=wordpress --dbuser=user --dbpass=password --dbhost=localhost --dbprefix=wp_ #añadir credenciales de la base de datos MYSQL
wp core install --url=yourdomain.com  --title=Site_Title --admiwp admin_user=admin_username --admin_password=admin_password --admin_email=your@email.com #añadir campos adicionales
wp theme activate tema --activate #instalar y activar tema
wp plugin install plugin --activate #instalar y activar plugin
