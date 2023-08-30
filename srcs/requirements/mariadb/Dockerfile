# Define la imagen base
FROM debian:buster

# Ejecuta comandos y crea una capa de imagen. Se utiliza para instalar paquetes en el contenedor.
RUN apt-get update
RUN apt-get install -y mariadb-server

# Copia archivos y directorios al contenedor
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools /var/www/

# Indica la necesidad de abrir el puerto
EXPOSE 3306

# Inicia el servicio de MySQL, ejecuta un script SQL y luego elimina el archivo
RUN service mysql start && mysql < /var/www/createdb.sql && rm -f /var/www/createdb.sql

# Describe el comando con argumentos que se ejecutará cuando se inicie el contenedor
CMD /usr/bin/mysqld_safe
