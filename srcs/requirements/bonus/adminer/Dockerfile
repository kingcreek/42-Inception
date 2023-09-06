FROM debian:buster


RUN apt-get update

COPY ./tools/script.sh /

RUN apt-get install wget -y && apt-get install php php-mysql  -y


CMD ["./script.sh"]