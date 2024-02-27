FROM debian:bullseye

EXPOSE 443
#actualizar apt
RUN	apt-get update && apt-get upgrade

#instalar nginx y openssl
RUN	apt install -y nginx && apt install openssl -y

RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 -sha256 -days 365 -newkey rsa:2048 -subj "/C=ES/ST=Madrid/L=Madrid/O=42/OU=pfuentes/CN=pfuentes.42.fr/" -nodes -keyout /etc/nginx/ssl/pfuentes.key -out /etc/nginx/ssl/pfuentes.csr    

#COPY tools/script.sh /usr/local/bin/script.sh
#RUN chmod +x /usr/local/bin/script.sh
COPY config/config.conf /etc/nginx/conf.d/default.conf
#COPY config/index.html /usr/share/nginx/html/index.html
#comando a ejecutar, hacer un script para no sobrecargar la imagen
CMD ["nginx", "-g", "daemon off;"]