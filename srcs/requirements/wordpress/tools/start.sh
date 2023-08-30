#!/bin/bash

# Reemplaza todas las instancias de una cadena en un archivo, sobrescribiendo el archivo:
sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";
# -R cambia recursivamente los permisos de los directorios y su contenido
chmod -R 775 /var/www/html/wordpress;
# El siguiente ejemplo cambiará el propietario de todos los archivos y 
# subdirectorios en el directorio /var/www/html/wordpress a un nuevo propietario y al grupo www-data:
chown -R www-data /var/www/html/wordpress;
mkdir -p /run/php/;
touch /run/php/php7.3-fpm.pid;

# php -S 0.0.0.0:9000 -t /var/www/html/wordpress

if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
echo "Wordpress: configurando..."
# Después de verificar los requisitos, descargue el archivo wp-cli.phar 
# usando wget o curl:
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
# "+x" significa dar permisos de ejecución (x) al archivo para todos los usuarios.
chmod +x wp-cli.phar;
# Para usar WP-CLI desde la línea de comandos escribiendo wp, 
# haga el archivo ejecutable y muévalo a algún lugar en el PATH. Por ejemplo:
mv wp-cli.phar /usr/local/bin/wp;
cd /var/www/html/wordpress;
# Descarga y extrae los archivos principales de WordPress en la ruta especificada.

# sitio web estático
mkdir -p /var/www/html/wordpress/mysite;
mv /var/www/index.html /var/www/html/wordpress/mysite/index.html;

wp core download --allow-root;
mv /var/www/wp-config.php /var/www/html/wordpress;
echo "Wordpress: creando usuarios..."
# Crea las tablas de WordPress en la base de datos 
# usando la URL, el título y los datos proporcionados para el usuario administrador por defecto.
# --url=<dirección>
# Dirección del nuevo sitio.
# --title=<nombre del sitio>
# Nombre del nuevo sitio.
# --admin_user=<nombre de usuario>
# Nombre de usuario del administrador.
# [--admin_password=<contraseña>]
# Contraseña para el administrador. De forma predeterminada, se utiliza una cadena generada aleatoriamente.
# --admin_email=<correo electrónico>
# Correo electrónico del administrador.
wp core install --allow-root --url=${DOMAIN_NAME} --title=${WORDPRESS_NAME} --admin_user=${WORDPRESS_ROOT_LOGIN} --admin_password=${MYSQL_ROOT_PASSWORD} --admin_email=${WORDPRESS_ROOT_EMAIL};
# Crea un nuevo usuario
# <nombre-de-usuario>
# Nombre de usuario para crear.
# <correo-electrónico-de-usuario>
# Correo electrónico del usuario para crear.
# [--role=<rol>]
# Rol del usuario para crear. De forma predeterminada: rol predeterminado.
# Los valores posibles incluyen "administrador", "editor", "autor", "colaborador", "seguidor".
# [--user_pass=<contraseña>]
# Contraseña del usuario. De forma predeterminada: generada aleatoriamente.
wp user create ${MYSQL_USER} ${WORDPRESS_USER_EMAIL} --user_pass=${MYSQL_PASSWORD} --role=author --allow-root;
# Tema de WordPress
wp theme install inspiro --activate --allow-root

# habilitar la caché de redis
sed -i "40i define( 'WP_REDIS_HOST', '$REDIS_HOST' );"      wp-config.php
sed -i "41i define( 'WP_REDIS_PORT', 6379 );"               wp-config.php
#sed -i "42i define( 'WP_REDIS_PASSWORD', '$REDIS_PWD' );"   wp-config.php
sed -i "42i define( 'WP_REDIS_TIMEOUT', 1 );"               wp-config.php
sed -i "43i define( 'WP_REDIS_READ_TIMEOUT', 1 );"          wp-config.php
sed -i "44i define( 'WP_REDIS_DATABASE', 0 );\n"            wp-config.php

wp plugin install redis-cache --activate --allow-root
wp plugin update --all --allow-root

echo "Wordpress: ¡configurado!"
else
echo "Wordpress: ¡ya está configurado!"
fi

wp redis enable --allow-root

echo "Wordpress iniciado en :9000"
/usr/sbin/php-fpm7.3 -F
