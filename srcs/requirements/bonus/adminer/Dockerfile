FROM debian:buster


RUN apt-get update

COPY ./tools/script.sh /

RUN apt-get install wget -y && apt-get install php php-mysql php-pgsql  -y

RUN chmod +x script.sh
CMD ["./script.sh"]
