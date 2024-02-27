FROM alpine:3.18.3

#EXPOSE 3306

RUN apk update && apk add mariadb mariadb-client openrc --no-cache

COPY ./config/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./config/my.cnf /etc/mysql/my.cnf

COPY ./config/my.cnf /etc/my.cnf

COPY ./tools/script.sh /

RUN chmod +x /script.sh

CMD ["sleep", "infinity"]

#CMD ["/script.sh"]

