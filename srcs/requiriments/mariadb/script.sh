#!/bin/bash

mysql_install_db #instalar base de datos

echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY '$MDB_PASSWORD';"

if [! -d "/var/lib/mysql/$MDB_NAME"];
then

mysql_secure_installation; # instalación segura
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
sudo systemctl restart mariadb # reiniciar servidor mariadb
mysql -u root -p #conectarse a mariadb
#introducir contraseña creada antes -> "echo $MDB_PASSWORD"
#crear nueva base de datos para host externo/remoto
echo "CREATE DATABASE $MDB_NAME"
echo "CREATE USER '$MDB_USER'@'localhost' IDENTIFIED BY '$MDB_PASSWORD'"
echo "GRANT ALL PRIVILEGES ON '$MDB_NAME'.* to '$MDB_USER'@'localhost' IDENTIFIED BY '$MDB_PASSWORD'"
echo "FLUSH PRIVILIGES"
echo "exit"

#else

fi
