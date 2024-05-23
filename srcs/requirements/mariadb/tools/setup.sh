#! /bin/sh

chown -R mysql: /var/lib/mysql
chmod 777 /var/lib/mysql

mysql_install_db >/dev/null 2>&1

if [ ! -d "/var/lib/mysql/$MDB_DATABASE" ]; then
  rm -f "$MDB_INIT_FILE"
  #mysqld_secure_installation 
  echo "Starting MySQL secure installation..."
  #change root password
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MDB_ROOT_PASSWORD';" >> mysql_secure_installation.sql
  echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" >> $MDB_INIT_FILE
  #remove anonymous users
  echo "DROP USER ''@'localhost';" >> $MDB_INIT_FILE
  echo "DROP USER ''@'$(hostname)';" > $MDB_INIT_FILE
  #remove test database
  echo "DROP DATABASE test;" >> $MDB_INIT_FILE
  echo "MySQL secure installation completed!"
  #create wordpress database and user
  echo "Creating Wordpress database and user..."
  #create database
  echo "CREATE DATABASE $MDB_DATABASE;" >> $MDB_INIT_FILE
  #create user
  echo "CREATE USER '$MDB_USER'@'%' IDENTIFIED by '$MDB_PASSWORD';" >> $MDB_INIT_FILE
  #give privileges to user on database
  echo "GRANT ALL PRIVILEGES ON $MDB_DATABASE.* TO '$MDB_USER'@'%';" >> $MDB_INIT_FILE
  #apply changes
  echo "FLUSH PRIVILEGES;" >> $MDB_INIT_FILE
  echo "Wordpress database and user successfully created!"
  mysqld_safe --init-file=$MDB_INIT_FILE >/dev/null 2>&1
else
  mysqld_safe >/dev/null 2>&1
fi
echo "Starting MariaDB server..."
