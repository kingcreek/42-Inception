FROM debian:buster

# Instalar herramientas necesarias
RUN apt-get update \
    && apt-get install -y wget tar apache2-utils \
    && rm -rf /var/lib/apt/lists/*

# Descargar e instalar Portainer
RUN wget https://github.com/portainer/portainer/releases/download/2.19.0/portainer-2.19.0-linux-amd64.tar.gz \
    && tar xvzf portainer-2.19.0-linux-amd64.tar.gz \
    && rm -rf portainer-2.19.0-linux-amd64.tar.gz

COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]
