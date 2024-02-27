#!/bin/bash

#mysql_install_db #instalar base de datos

#echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY '$MDB_PASSWORD';"
echo "SCRIPT MARIADB"
sleep 5

echo "---------START MARIADB---------"
sudo systemctl start mariadb
sleep 5
echo "---------STATUS MARIADB---------"
sudo systemctl status mariadb
sleep 5
echo "---------INFO MARIADB---------"
mysqladmin version
#chown -R mysql: /var/lib/mysql
#chmod 777 /var/lib/mysql

#mysql_install_db >/dev/null 2>&1

#service mysql start;
# instalación segura
mysql_secure_installation
#Y
#n
#$MYSQL_ROOT_PASSWORD
#Y
#Y
#Y
#Y
#END
#echo "MYSQL SECURE INSTALLATION DONE!"
#introducir password de sudo -debe ser segura
#validar password - y - 3 niveles 0 1 2 - y
#introducir password
#volver a introducir password
#eliminar usuarios anonimos - y
#desabilitar login remoto al root - y
#eliminar database test y acceso a ella - y
#eliminar privilegios de tablas - y

#por defecto mariadb acepta solo conexiones en socket unix, no en conexión tcp - listar conexion tcp -> ss -nlt
#permitir conexion remota -> fichero 50-server.cnf -> cambiar bind-address = 0.0.0.0
#mysql -u $MDB_USER -p $MDB_PASSWORD -h $MDB_HOST #conectarse a mariadb
#introducir contraseña creada antes -> "echo $MDB_PASSWORD"
#crear nueva base de datos para host externo/remoto
#usar como nombre de base de datos una variable de entorno
#mariadb

#MYSQL_ROOT_PASSWORD=mariadbrootpwd
#MYSQL_USER=mariadbuser
#MYSQL_PASSWORD=mariadbuserpwd
#MYSQL_INIT_FILE=mariadbinitfile
#CREAR USUARIO "NORMAL"
#echo "CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
#echo "CREATE USER $MYSQL_USER@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb
echo "GRANT ALL PRIVILEGES ON *.* to '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD' WITH GRANT OPTION;"
#echo "GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;"
echo "FLUSH PRIVILEGES;"
echo "EXIT;"
#echo "CREATE DATABASE $MDB_NAME" > "$MYSQL_INIT_FILE"
#echo "CREATE USER $MDB_USER@'%' IDENTIFIED BY '$MDB_PASSWORD';" >> "$MYSQL_INIT_FILE"
#echo "CREATE USER '$MDB_USER'@'localhost' IDENTIFIED BY '$MDB_PASSWORD';" >> "$MYSQL_INIT_FILE"
#echo "GRANT ALL PRIVILEGES ON $MDB_NAME.* to '$MDB_USER'@'%' IDENTIFIED BY '$MDB_PASSWORD' WITH GRANT OPTION" >> "$MYSQL_INIT_FILE"
#echo "GRANT ALL PRIVILEGES ON $MDB_NAME.* to '$MDB_USER'@'localhost' IDENTIFIED BY '$MDB_PASSWORD' WITH GRANT OPTION" >> "$MYSQL_INIT_FILE"
#echo "FLUSH PRIVILIGES" >> $MYSQL_INIT_FILE

#mysql < tmp.sql
#kill $(cat /var/run/mysqld/mysqld.pid)
#touch /mdb_wp
#chmod 444 /mdb_wp
systemctl status mariadb
mysqladmin version
systemctl start mariadb
#/etc/init.d/mysql stop
