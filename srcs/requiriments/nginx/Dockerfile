FROM debian:buster

#actualizar apt
RUN	apt update -y && apt upgrade -y

#instalar nginx y openssl
RUN	apt install -y nginx && apt install openssl -y

COPY tools tools
COPY config/config.conf /etc/nginx/conf.d/default.conf
#comando a ejecutar, hacer un script para no sobrecargar la imagen
CMD ["tools/script"] 