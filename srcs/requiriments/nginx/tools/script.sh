#!/bin/bash

mkdir /etc/nginx/ssl
#generar clave privada y CSR
# openssl – activates the OpenSSL software , req – indicates that we want a CSR, –new –newkey – generate a new key /
# rsa:2048 – generate a 2048-bit RSA mathematical key, –nodes – no DES, meaning do not encrypt the private key in a PKCS#12 file,
# –keyout – indicates the domain you’re generating a key for, –out – specifies the name of the file your CSR will be saved as
openssl req -x509 \
        -sha256 -days 365 \
        -newkey rsa:2048 \
        -subj "/C=ES/ST=Madrid/L=Madrid/O=42/OU=pfuentes/CN=pfuentes.42.fr/" -nodes -keyout /etc/nginx/ssl/pfuentes.key \
        -out /etc/nginx/ssl/pfuentes.csr    

echo "Execute nginx!"

nginx -g "daemon off;"