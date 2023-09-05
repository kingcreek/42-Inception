FROM debian:buster


RUN apt-get update \
    && apt-get install -y wget tar \
    && wget https://github.com/portainer/portainer/releases/download/2.19.0/portainer-2.19.0-linux-amd64.tar.gz \
    && tar xvzf /portainer-2.19.0-linux-amd64.tar.gz \
    && rm -rf portainer-2.19.0-linux-amd64.tar.gz
# RUN mkdir /data
CMD ["/portainer/portainer"]