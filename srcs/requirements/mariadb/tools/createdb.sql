CREATE DATABASE wordpress;
CREATE USER 'rbiodies'@'%' IDENTIFIED BY '123123';
-- Para GRANT ALL PRIVILEGES para rbiodies, que le otorga control total sobre la base de datos wordpress
-- Estos privilegios están destinados para wordpress y se aplican a todas las tablas de esta base de datos,
-- como se indica con .* de la siguiente manera
GRANT ALL PRIVILEGES ON wordpress.* TO 'rbiodies'@'%';
-- Guardar los cambios
FLUSH PRIVILEGES;

-- Para cambiar la autenticación o las características de recursos de la base de datos de un usuario de base de datos
-- Para permitir que el servidor proxy se conecte como cliente sin autenticación
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root123123';
