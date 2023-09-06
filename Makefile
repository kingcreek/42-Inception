all:	up

# Podemos ejecutar nuestros contenedores utilizando el comando docker-compose up,
# que creará y ejecutará nuestros contenedores y servicios en el orden que especifiquemos.
# Cree los contenedores utilizando el comando docker-compose up y la bandera -d,
# que ejecutará los contenedores mariadb, wordpress y nginx en segundo plano.
up:
		@mkdir -p /home/${USER}/data/db
		@mkdir -p /home/${USER}/data/wp
		@mkdir -p /home/${USER}/data/prt
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
		sudo rm -Rf /home/${USER}/data/db
		sudo rm -Rf /home/${USER}/data/wp
		sudo rm -Rf /home/${USER}/data/prt
		mkdir /home/${USER}/data/db
		mkdir /home/${USER}/data/wp
		mkdir /home/${USER}/data/prt

# Cree o reconstruya los servicios
re:
		@mkdir -p ../data/wp
		@mkdir -p ../data/db
		@mkdir -p ../data/prt
		@docker-compose -f srcs/docker-compose.yml build
		docker-compose -f srcs/docker-compose.yml up

.PHONY:	all up down ps fclean re
