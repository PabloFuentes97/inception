#! /bin/sh

chown -R mysql: /var/lib/mysql
chmod 777 /var/lib/mysql

mysql_install_db

if [ ! -d "/var/lib/mysql/$MDB_DATABASE" ]; then
  rm -f "$MDB_INIT_FILE"
  add_query_line "CREATE DATABASE $MDB_DATABASE;"
  add_query_line "CREATE USER $MDB_USER@'%' IDENTIFIED BY '$MDB_PASSWORD';" >> "$MDB_INIT_FILE"
  add_query_line "CREATE USER $MDB_USER@'localhost' IDENTIFIED BY '$MDB_PASSWORD';" >> "$MDB_INIT_FILE"
  add_query_line "GRANT ALL PRIVILEGES ON $MDB_DATABASE.* TO $MDB_USER@'%' WITH GRANT OPTION;" >> "$MDB_INIT_FILE"
  add_query_line "GRANT ALL PRIVILEGES ON $MDB_DATABASE.* TO $MDB_USER@'localhost' WITH GRANT OPTION;" >> "$MDB_INIT_FILE"
  add_query_line "FLUSH PRIVILEGES;" >> "$MDB_INIT_FILE"
  add_query_line "DROP USER 'root'@'localhost';" >> "$MDB_INIT_FILE"
  add_query_line "CREATE USER 'root'@'localhost' IDENTIFIED BY '$MDB_ROOT_PASSWORD';" >> "$MDB_INIT_FILE"
  add_query_line "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" >> "$MDB_INIT_FILE"
  add_query_line "FLUSH PRIVILEGES;" >> "$MDB_INIT_FILE"
  mysqld_safe --init-file=$MDB_INIT_FILE
else
  mysqld_safe
fi