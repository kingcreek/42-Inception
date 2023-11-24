FROM debian:buster

RUN apt-get update
RUN apt-get install -y redis

COPY tools/configure.sh /var/www/configure.sh

CMD ["/bin/bash", "/var/www/configure.sh"]