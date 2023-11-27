FROM debian:buster

RUN apt-get update
RUN apt-get install -y mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools /var/www/

EXPOSE 3306

RUN service mysql start && mysql < /var/www/createdb.sql && rm -f /var/www/createdb.sql

CMD /usr/bin/mysqld_safe
