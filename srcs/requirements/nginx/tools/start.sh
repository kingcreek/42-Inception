# -openssl
# Utilidad para crear certificados
# -Comando req
# Principalmente crea y maneja solicitudes de certificados
# -x509
# Esta opción emite un certificado autofirmado en lugar de una solicitud de certificado.
# Por lo general, se utiliza para crear un certificado de prueba o una autoridad de certificación autofirmada.
# -nodes
# Si esta opción se especifica, el archivo de clave privada no se cifrará.
# days n
# Cuando se utiliza la opción -x509, esta indica el número de días para certificar el certificado.
# -newkey argumento
# Esta opción crea una nueva solicitud de certificado y una nueva clave privada.
# El argumento toma una de varias formas. rsa:nbits, donde nbits es el número de bits, genera una clave RSA con nbits de tamaño.
# -keyout nombre de archivo
# Esto proporciona un nombre de archivo para escribir la nueva clave privada creada.
# -out nombre de archivo
# Esto indica el nombre del archivo de salida para escribir o la salida estándar por defecto.
# -subj argumento
# Sustituye el campo de asunto de la solicitud de entrada por los datos especificados y muestra la solicitud modificada.

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
echo "Nginx: setting up ssl ...";
openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
		-keyout /etc/ssl/private/nginx.key \
		-out /etc/ssl/certs/nginx.crt \
		-subj "/C=RU/ST=Tatarstan/L=Kazan/O=wordpress/CN=rbiodies.42.fr";
echo "Nginx: ssl is set up!";
fi

# Run nginx.
# Nginx utiliza la directiva 'daemon off' para ejecutarse en primer plano.
nginx -g 'daemon off;';