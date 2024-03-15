FROM alpine:3.18.3

EXPOSE 443

RUN	apk update && apk upgrade && apk add --no-cache nginx openssl

RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 \ 
	-nodes \
	-sha256 \
	-days 365 \
	-newkey rsa:2048 \
	-subj "/C=ES/ST=Madrid/L=Madrid/O=42/OU=pfuentes/CN=pfuentes.42.fr/" \
	-keyout /etc/nginx/ssl/pfuentes.key \
	-out	/etc/nginx/ssl/pfuentes.csr

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
