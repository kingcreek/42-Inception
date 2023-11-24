#!/bin/bash

export ADMIN_PASSWORD_HASH=$(htpasswd -nbB $PORTAINER_USER $PORTAINER_PWD | cut -d ":" -f 2)

# Ejecutar Portainer con la contraseña del administrador
exec /portainer/portainer --admin-password="$ADMIN_PASSWORD_HASH"