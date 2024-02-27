#!/bin/bash

if [ ! -f /var/lib/mysql/ibdata1 ]; then
	#bind to every available network instead of just localhost
	mysql_install_db --admin-user=$MDB_USER --admin-host=0.0.0.0 >/dev/null 2>&1
	sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
	mysql
	echo "ALTER USER '$MDB_USER' IDENTIFIED BY '$MDB_PASSWORD';"
	echo "FLUSH_PRIVILEGES;"
	echo "EXIT;"
	rm ~/home/.mysql_secret
	#/usr/bin/mysqld_safe
	sleep 10s
	mariadb
	#create admin account to administer things from outside of the container
	echo "GRANT ALL ON *.* TO $MDB_USER@'%' IDENTIFIED BY '$MDB_PASSWORD' WITH GRANT OPTION;"
	echo "FLUSH PRIVILEGES;"
	echo "EXIT;"
	mysql

	killall mysqld
	sleep 10s
fi
echo "LO HIZO BIEN"
/usr/bin/mysqld_safe >/dev/null 2>&1