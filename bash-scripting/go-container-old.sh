#!/bin/bash

if [ $# -eq 0 ]; then
	echo -e " "
    read -p "Por favor, ingresa un parámetro (1, 2 o 9): " input
else
    input=$1
fi

if [ "$input" == "1" ] || [ "$input" == "01" ]; then
    CONTAINER_NAME="01-nginx"
    # Verificar si el contenedor está en ejecución
    if [ "$(docker inspect -f '{{.State.Running}}' $CONTAINER_NAME 2>/dev/null)" == "true" ]; then
        clear
        echo -e "\nIngresando al contenedor $CONTAINER_NAME :"
        docker exec -it $CONTAINER_NAME /bin/bash
    else
        # Mostrar mensaje de que el contenedor no está en ejecución
        echo -e "\nEl contenedor $CONTAINER_NAME no está en ejecución.\n"
    fi


elif [ "$input" == "2" ] || [ "$input" == "02" ]; then
    CONTAINER_NAME="02-php"
    # Verificar si el contenedor está en ejecución
    if [ "$(docker inspect -f '{{.State.Running}}' $CONTAINER_NAME 2>/dev/null)" == "true" ]; then
        clear
        echo -e "\nIngresando al contenedor $CONTAINER_NAME :"
        docker exec -it $CONTAINER_NAME /bin/bash
    else
        # Mostrar mensaje de que el contenedor no está en ejecución
        echo -e "\nEl contenedor $CONTAINER_NAME no está en ejecución.\n"
    fi


elif [ "$input" == "3" ] || [ "$input" == "03" ]; then
    CONTAINER_NAME="03-mariadb"
    # Verificar si el contenedor está en ejecución
    if [ "$(docker inspect -f '{{.State.Running}}' $CONTAINER_NAME 2>/dev/null)" == "true" ]; then
        clear
        echo -e "\nIngresando al contenedor $CONTAINER_NAME :"
        docker exec -it $CONTAINER_NAME /bin/bash
    else
        # Mostrar mensaje de que el contenedor no está en ejecución
        echo -e "\nEl contenedor $CONTAINER_NAME no está en ejecución.\n"
    fi


elif [ "$input" == "9" ] || [ "$input" == "09" ]; then
    CONTAINER_NAME="09-gulp"
    # Verificar si el contenedor está en ejecución
    if [ "$(docker inspect -f '{{.State.Running}}' $CONTAINER_NAME 2>/dev/null)" == "true" ]; then
        clear
        echo -e "\nIngresando al contenedor $CONTAINER_NAME :"
        docker exec -it $CONTAINER_NAME /bin/bash
    else
        # Mostrar mensaje de que el contenedor no está en ejecución
        echo -e "\nEl contenedor $CONTAINER_NAME no está en ejecución.\n"
    fi





else
    echo -e "\nNo se reconoce el parámetro proporcionado.\n"
    exit 1
fi



