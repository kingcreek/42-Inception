all:	up

# Podemos ejecutar nuestros contenedores utilizando el comando docker-compose up,
# que creará y ejecutará nuestros contenedores y servicios en el orden que especifiquemos.
# Cree los contenedores utilizando el comando docker-compose up y la bandera -d,
# que ejecutará los contenedores mariadb, wordpress y nginx en segundo plano.
up:
		@mkdir -p /home/${USER}/data/mariadb
		@mkdir -p /home/${USER}/data/wordpress
		@mkdir -p /home/${USER}/data/portainer
		@mkdir -p /home/${USER}/data/adminer
#		@docker-compose -f srcs/docker-compose.yml up --detach --build
		@docker-compose -f srcs/docker-compose.yml up --build
#		@docker-compose -f srcs/docker-compose.yml up -d

# El comando docker-compose down detendrá sus contenedores, pero también eliminará los contenedores detenidos,
# así como todas las redes creadas.
down:
		@docker-compose -f srcs/docker-compose.yml down

# Lista de contenedores
ps:
		@docker-compose -f srcs/docker-compose.yml ps

# El comando docker system prune es un atajo que elimina imágenes, contenedores y redes.
# Los volúmenes no se eliminan de forma predeterminada, y debe especificar la bandera --volumes
# para que el sistema Docker reduzca la cantidad de volúmenes. De forma predeterminada, se le pedirá confirmación.
# Para evitar la indicación, use la bandera -f o --force.
# Si se especifica `-a`, también se eliminarán todas las imágenes a las que no hace referencia ningún contenedor.
fclean:	down
		@docker rmi -f $$(docker images -qa);\
		docker volume rm $$(docker volume ls -q);\
		docker system prune -a --force
		sudo rm -Rf /home/${USER}/data/mariadb
		sudo rm -Rf /home/${USER}/data/wordpress
		sudo rm -Rf /home/${USER}/data/portainer
		sudo rm -Rf /home/${USER}/data/adminer
		mkdir /home/${USER}/data/mariadb
		mkdir /home/${USER}/data/wordpress
		mkdir /home/${USER}/data/portainer
		mkdir /home/${USER}/data/adminer

# Cree o reconstruya los servicios
re:
		@mkdir -p ../data/wordpress
		@mkdir -p ../data/mariadb
		@mkdir -p ../data/portainer
		@mkdir -p ../data/adminer
		@docker-compose -f srcs/docker-compose.yml build
		docker-compose -f srcs/docker-compose.yml up

.PHONY:	all up down ps fclean re
