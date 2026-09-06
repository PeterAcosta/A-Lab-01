#!/bin/bash


# Verificar si existe el archivo '/tmp/00-php-8-fpm-docker-init.log'
if [ -f '/tmp/00-php-8-fpm-docker-init.log' ]; then
    # Primera vez que corre
    mkdir -p -m 755 /var/log/php

    mv '/tmp/00-php-8-fpm-docker-init.log' /var/log/php/00-php-8-fpm-docker-init.log
    echo -e $(date +"1a- %Y-%m-%d  %A  %T - Entrypoint : moviendo /tmp/00-php-8-fpm-docker-init.log")  >> /var/log/php/00-php-8-fpm-docker-init.log

    chown -R www-data:www-data /var/log/php
    echo -e $(date +"1b- %Y-%m-%d  %A  %T - Entrypoint : chown -R www-data:www-data /var/log/php")  >> /var/log/php/00-php-8-fpm-docker-init.log


    PHP_INI_FILE='usr-local-etc-php--php.ini-development'
    # PHP_INI_FILE='usr-local-etc-php--php.ini-production'
    # PHP_INI_FILE='usr-local-etc-php--php.ini.prod.custom'
    cp "/x-include/$PHP_INI_FILE"  /usr/local/etc/php/php.ini
    echo -e $(date +"1c- %Y-%m-%d  %A  %T - Entrypoint : moved $PHP_INI_FILE")  >> /var/log/php/00-php-8-fpm-docker-init.log

    sleep 4
else 
    echo -e $(date +"\n1 - %Y-%m-%d  %A  %T - Entrypoint : starting")  >> /var/log/php/00-php-8-fpm-docker-init.log
fi





regla="\e[0;34m---------------------------------------------------------------------------\e[0m"
echo -e $regla 


## CRON
service cron restart 
echo -e $(date +"2 - %Y-%m-%d  %A  %T - Entrypoint : restarted cron")  >> /var/log/php/00-php-8-fpm-docker-init.log



# logrotate -f /etc/logrotate.conf  ## con -f fuerza a rotar
# logrotate /etc/logrotate.conf     ## sin -f no fuerza a rotar


## PHP
echo -e $(date +"3 - %Y-%m-%d  %A  %T - Entrypoint : starting php-fpm")  >> /var/log/php/00-php-8-fpm-docker-init.log

php-fpm 

echo -e $(date +"4 - %Y-%m-%d  %A  %T - Entrypoint : php-fpm has stopped !!!")  >> /var/log/php/00-php-8-fpm-docker-init.log







