FROM alpine:3.18.3

RUN apk update && apk add mariadb mariadb-client

COPY ./conf/my.cnf /etc/my.cnf
COPY ./tools/setup.sh /usr/bin/setup.sh

RUN chmod +x /usr/bin/setup.sh

CMD ["/usr/bin/setup.sh"]
