#! /bin/sh

chown -R mysql: /var/lib/mysql
chmod 777 /var/lib/mysql

mysql_install_db >/dev/null 2>&1

if [ ! -d "/var/lib/mysql/$MDB_DATABASE" ]; then

mysql_secure_installation << _EOF_

n
$ROOT_PASSWORD
$ROOT_PASSWORD
y
y
y
y
_EOF_

echo "MariaDB secure installation completed!"

  rm -f "$MDB_INIT_FILE"
  #echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MDB_ROOT_PASSWORD';" >> $MDB_INIT_FILE
  echo "CREATE DATABASE $MDB_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $MDB_INIT_FILE
  echo "CREATE USER '$MDB_USER'@'%' IDENTIFIED by '$MDB_PASSWORD';" >> $MDB_INIT_FILE
  echo "GRANT ALL PRIVILEGES ON $MDB_DATABASE.* TO '$MDB_USER'@'%';" >> $MDB_INIT_FILE
  echo "FLUSH PRIVILEGES;" >> $MDB_INIT_FILE
  mysqld_safe --init-file=$MDB_INIT_FILE >/dev/null 2>&1
else
  mysqld_safe >/dev/null 2>&1
fi
echo "Starting MariaDB server..."
