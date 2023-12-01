FROM debian:buster

RUN apt-get update && apt-get install -y php7.3-fpm php7.3-mysql mariadb-client curl


EXPOSE 9000

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY ./tools /var/www/

RUN chmod +x /var/www/start.sh
CMD ["/var/www/start.sh"]