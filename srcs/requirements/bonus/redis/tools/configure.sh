if [ ! -f "/etc/redis/redis.conf.bak" ]; then

	cp /etc/redis/redis.conf /etc/redis/redis.conf.bak

	# Para cambiar la dirección IP en todos los archivos de zona, utiliza el siguiente comando:
	# -i para cambiar el archivo in situ, s para sustitución
	sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis/redis.conf
	# Cambia 'foobared' por tu contraseña
	# sed -i "s|# requirepass foobared|requirepass $REDIS_PWD|g" /etc/redis.conf
	# Cuando la memoria de tu instancia de Redis se llena y llega un nuevo registro,
	# Redis desaloja claves para liberar espacio para la escritura, de acuerdo con la política maxmemory de tu instancia
	sed -i "s|# maxmemory <bytes>|maxmemory 2mb|g" /etc/redis/redis.conf
	# noeviction
	# Esta política de desalojo le dice a Redis que no elimine datos cuando se alcance el límite de memoria.
	# En lugar de eso, Redis retornará un error y no podrá ejecutar comandos para agregar datos.
	# Esta política es útil cuando se necesita eliminar claves manualmente o prevenir la pérdida accidental de datos.
	# allkeys-lru
	# La segunda política es allkeys-lru. Este tipo de política desaloja la clave menos recientemente utilizada (LRU).
	# Esta política asume que no se necesitan claves utilizadas recientemente y las elimina,
	# lo que evita errores de Redis debido a la limitación de memoria.
	sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis/redis.conf

fi

# El servidor Redis retornará un error a cualquier cliente que se conecte a direcciones de bucle invertido externas en modo protegido
redis-server --protected-mode no
