#!/bin/bash

# Reemplaza todas las instancias de una cadena en un archivo, sobrescribiendo el archivo:
#sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";
# -R cambia recursivamente los permisos de los directorios y su contenido
#chmod -R 775 /var/www/html/wordpress;
# El siguiente ejemplo cambiará el propietario de todos los archivos y 
# subdirectorios en el directorio /var/www/html/wordpress a un nuevo propietario y al grupo www-data:
#chown -R www-data /var/www/html/wordpress;
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
# mkdir -p /var/www/html/wordpress/mysite;
# mv /var/www/index.html /var/www/html/wordpress/mysite/index.html;

wp core download --allow-root;

#set permissons
# chmod -R 775 /var/www/html/wordpress;
# chown -R www-data /var/www/html/wordpress;
# chown -R www-data:www-data /var/www/html/wordpress;
# chmod -R 755 /var/www/html/wordpress;


wp config create --allow-root --dbname=$DB_DATABASE --dbhost=$DB_HOST --dbprefix=wp_ --dbuser=$USER --dbpass=$DB_USER_PASSWORD

echo "Wordpress: creando usuarios..."

wp core install --allow-root --url=${DOMAIN_NAME} --title=${WORDPRESS_NAME} --admin_user=${WORDPRESS_ROOT_LOGIN} --admin_password=${WORDPRESS_ROOT_PASSWORD} --admin_email=${WORDPRESS_ROOT_EMAIL};

wp user create ${WORDPRESS_LOGIN} ${WORDPRESS_USER_EMAIL} --user_pass=${WORDPRESS_PASSWORD} --role=author --allow-root;

wp theme install twentyseventeen --activate --allow-root

wp plugin install redis-cache --activate --allow-root
wp config set WP_REDIS_HOST "$REDIS_HOST" --add --allow-root
wp config set WP_CACHE true --add --allow-root
wp redis enable --allow-root


wp option update comment_moderation 0 --allow-root
wp option update comment_whitelist 1 --allow-root
wp option update comment_registration 1 --allow-root

echo "Wordpress: ¡configurado!"
else
echo "Wordpress: ¡ya está configurado!"
fi



echo "Wordpress iniciado en :9000"
/usr/sbin/php-fpm7.3 --nodaemonize --allow-to-run-as-root
