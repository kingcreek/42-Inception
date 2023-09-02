#!/bin/sh
#   _   _   _     _   _   _   _   _   _   _   _   _   _   _  
#  / \ / \ / \   / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ 
# ( S | S | L ) ( C | e | r | t | i | f | i | c | a | t | e )
#  \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ 

# *************************************************************************** #

# Check if SO is ubuntu
if [[ $(cat /etc/os-release | grep "Ubuntu") ]]; then
    # add routes to /etc/hosts
    echo "127.0.0.1 imurugar.42.fr" >> /etc/hosts
    echo "127.0.0.1 www.imurugar.42.fr" >> /etc/hosts
    echo "127.0.0.1 https://www.imurugar.42.fr" >> /etc/hosts
fi

apk add --no-cache nginx openssl
mkdir -p /etc/nginx/ssl
openssl req -x509 -new -newkey rsa:4096 -nodes -keyout /etc/nginx/ssl/imurugar.key -out /etc/nginx/ssl/imurugar.crt -subj "/C=ES/ST=/L=/O=/OU=/CN=imurugar.42.fr"
# *************************************************************************** #
