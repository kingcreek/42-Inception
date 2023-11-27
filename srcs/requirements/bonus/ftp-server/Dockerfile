FROM debian:buster

RUN apt-get update
RUN apt-get install -y vsftpd

COPY conf/vsftpd.conf /var/www/vsftpd.conf
COPY tools/configure.sh /var/www/configure.sh

RUN chmod +x /var/www/configure.sh

CMD ["/var/www/configure.sh"]