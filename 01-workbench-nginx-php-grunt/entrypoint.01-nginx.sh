#!/bin/bash


DOMAIN_NAME="test.local"
DOMAIN_DIR="/var/www/test"


# Verificar si el archivo "/tmp/00-mariadb-docker-init.log" existe
if [ -f '/tmp/00-nginx-docker-init.log' ]; then
    # Primera vez que corre

    mv /tmp/00-nginx-docker-init.log /var/log/nginx/00-nginx-docker-init.log
    echo -e $(date +"1a- %Y-%m-%d  %A  %T - Entrypoint : moviendo 00-nginx-docker-init.log")  >> /var/log/nginx/00-nginx-docker-init.log



    chown -R www-data:www-data "$DOMAIN_DIR"
    echo -e $(date +"1b- %Y-%m-%d  %A  %T - Entrypoint : chown -R www-data:www-data $DOMAIN_DIR")  >> /var/log/nginx/00-nginx-docker-init.log

    

    sleep 1
else 
    echo -e $(date +"\n1 - %Y-%m-%d  %A  %T - Entrypoint : starting")  >> '/var/log/nginx/00-nginx-docker-init.log'
fi


regla="\e[0;34m---------------------------------------------------------------------------\e[0m"
echo -e $regla 

## CRON
service cron restart 
echo -e $(date +"2 - %Y-%m-%d  %A  %T - Entrypoint : restarted cron")  >> '/var/log/nginx/00-nginx-docker-init.log'



# logrotate -f /etc/logrotate.conf  ## con -f fuerza a rotar
# logrotate /etc/logrotate.conf     ## sin -f no fuerza a rotar




echo -e $(date +"3 - %Y-%m-%d  %A  %T - Entrypoint : starting nginx")  >> '/var/log/nginx/00-nginx-docker-init.log'

nginx -g "daemon off;"

echo -e $(date +"4 - %Y-%m-%d  %A  %T - Entrypoint : nginx has stopped !!!")  >> '/var/log/nginx/00-nginx-docker-init.log'

