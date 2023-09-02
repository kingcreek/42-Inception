WORKDIR = ./srcs
DOCKER_COMPOSE_F = $(WORKDIR)/docker-compose.yml
ENV = $(WORKDIR)/.env

all: build up

build: 
		sudo docker-compose -f $(DOCKER_COMPOSE_F) build
stop:
		sudo docker-compose -f $(DOCKER_COMPOSE_F) stop
down:
		sudo docker-compose -f $(DOCKER_COMPOSE_F) down
		sudo rm -rf /home/${USER}/data/*
up:
		sudo mkdir -p /home/${USER}/data/mariadb
		sudo mkdir -p /home/${USER}/data/wordpress
		sudo mkdir -p /home/${USER}/data/portainer
		sudo docker-compose -f $(DOCKER_COMPOSE_F) up -d
fclean: down
clean: stop
re : down all

logs:
	sudo docker-compose -f $(DOCKER_COMPOSE_F) logs -f

.PHONY: up stop start build down fclean clean all