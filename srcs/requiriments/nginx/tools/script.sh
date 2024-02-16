#!/bin/bash

mkdir /etc/nginx/ssl

#generar clave privada y CSR
# openssl – activates the OpenSSL software , req – indicates that we want a CSR, –new –newkey – generate a new key /
# rsa:2048 – generate a 2048-bit RSA mathematical key, –nodes – no DES, meaning do not encrypt the private key in a PKCS#12 file,
# –keyout – indicates the domain you’re generating a key for, –out – specifies the name of the file your CSR will be saved as
openssl req -new -newkey rsa:2048 -nodes -keyout /etc/nginx/ssl/pfuentes.key -out /etc/nginx/ssl/pfuentes.csr -subj "/C=ES/ST=Madrid/L=Madrid/O=42/OU=pfuentes/CN=pfuentes.42.fr/"

#pre-requisitos
apt install curl gnupg2 ca-certificates lsb-release debian-archive-keyring

#importar signing key para que apt pueda verificar la autenticidad de los paquetes
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null 
#verificar que el archivo descargado contiene la key correcta
#fingerprint tiene que ser 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62; hacer un if para ver que es la misma, si no que borre el fichero
gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg 

#establecer repositorio apt para paquetes estables de nginx
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/debian `lsb_release -cs` nginx" \
    | tee /etc/apt/sources.list.d/nginx.list

#establecer que el repositorio prefiera paquetes de nginx antes que los de distribuciones
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | tee /etc/apt/preferences.d/99nginx 

nginx -g 'daemon off'