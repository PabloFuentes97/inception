#! /bin/sh

# install wordpress cli
if [ ! -f "/usr/local/bin/wp" ]; then
  echo "Installing WP-CLI..."
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --silent
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp
  echo "WP-CLI successfully installed!"
fi

# Set up wordpress
if [ ! -f /wordpress/wp-config.php ]; then
  echo "Configuring WordPress..."
  wp core download --path=/wordpress

  wp config create --path=/wordpress --dbname=$MDB_DATABASE --dbuser=$MDB_USER --dbpass=$MDB_PASSWORD --dbhost=$MDB_HOST

  wp core install --url=$DOMAIN_NAME --title=Inception --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email="$ADMIN_EMAIL" --path=/wordpress

  wp theme install --activate pixl --path=/wordpress

  wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --role=author --user_pass=$WORDPRESS_PASSWORD --path=/wordpress
  echo "WordPress successfully configured!"

fi

php-fpm81 --nodaemonize
