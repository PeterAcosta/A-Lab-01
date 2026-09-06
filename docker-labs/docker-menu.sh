#!/bin/bash

# ==============================================================================
# Script de Gestión de Contenedores Docker por Sistema Operativo
# ==============================================================================

# Definición de colores para la interfaz en terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BLUE_LIGHT='\033[1;34m'
BLUE_INTENSE='\033[0;94m'
CYAN='\033[0;36m'
NC='\033[0m' # Sin color

show_header() {
    clear
    echo -e "${CYAN}=================================================================================${NC}"
    echo -e "${YELLOW}             Docker Container runner / manager script - MULTI OS LAB          ${NC}"
    echo -e "${CYAN}================================================================================="
    echo -e "                           Peter's dev & test sandbox "
    echo -e "${CYAN}---------------------------------------------------------------------------------${NC}"
}

launch_container() {
    local service_name=$1
    local container_name=$2
    local os_label=$3

    echo -e "\n${NC}[+] Iniciando proceso para: ${YELLOW}${os_label}${NC}"
    
    # 1. Compilar imagen si no está construida
    echo -e "${BLUE}[i] Compilando/Verificando imagen para ${service_name}...${NC}"
    docker compose build $service_name

    if [ $? -ne 0 ]; then
        echo -e "${RED}[!] Error en el build de ${service_name}.${NC}"
        read -p "Presione Enter para continuar..."
        return
    fi

    # 2. Levantar el contenedor en segundo plano (detached)
    echo -e "${BLUE}[i] Levantando contenedor ${container_name}...${NC}"
    docker compose up -d $service_name

    if [ $? -eq 0 ]; then
        echo -e "\n${YELLOW}[✓] Contenedor ${container_name} iniciado correctamente.${NC}"
        read -p "¿Desea ingresar a la consola del contenedor ahora? (s/n): " ingresar
        if [[ "$ingresar" =~ ^[Ss]$ ]]; then
            echo -e "${NC}[*] Conectando a la shell de ${YELLOW}${container_name}...${NC}"
			echo -e "${CYAN}    (run: cat /etc/os-release )${NC}"
			echo -e "${CYAN}    (run: ./usr/local/bin/os-data.sh )${NC}\n"
            if [ "$service_name" == "os-1a-alpine" ]; then
				docker exec -it $container_name /bin/bash
            else
                docker exec -it $container_name /bin/bash
            fi
        fi
    else
        echo -e "${RED}[!] Error al levantar el contenedor ${service_name}.${NC}"
    fi

	echo -e "\n"
    read -p "Presione Enter para volver al menú principal..."
}

while true; do
    show_header
    echo -e " ${YELLOW} 1)${NC} Contenedor con Alpine 3.17           		(os-1a-alpine)"
    echo -e " ${YELLOW} 2)${NC} Contenedor con Debian 10 Buster      		(os-2a-debian-10-buster)"
    echo -e " ${YELLOW} 3)${NC} Contenedor con Debian 11 Bullseye    		(os-2b-debian-11-bullseye)"
    echo -e " ${YELLOW} 4)${NC} Contenedor con Debian 12 Bookworm    		(os-2c-debian-12-bookworm)"
    echo -e " ${YELLOW} 5)${NC} Contenedor con Debian 13 Trixie      		(os-2d-debian-13-trixie)"
    echo -e " ${YELLOW} 6)${NC} Contenedor con Ubuntu 23.04     Lunar Lobster	(os-3a-ubuntu-23-04)"
    echo -e " ${YELLOW} 7)${NC} Contenedor con Ubuntu 24.04 LTS Noble Numbat	(os-3b-ubuntu-24-04)"
    echo -e " ${YELLOW} 8)${NC} Contenedor con Ubuntu 26.04 LTS Resolute Raccoon	(os-3c-ubuntu-26-04)"
    echo -e " ${YELLOW} 9)${NC} Contenedor con CentOS 7.9            		(os-4a-centos-7-9-2009)"
    echo -e " ${YELLOW}10)${NC} Contenedor con RedHat UBI 8.7        		(os-5a-redhat-ubi8)"
    echo -e " ${YELLOW}11)${NC} Contenedor con Fedora 39             		(os-6a-fedora-39)"
    echo -e " ${YELLOW}12)${NC} Contenedor con Fedora 44            		(os-6b-fedora-44)"
    echo -e " ${YELLOW}13)${NC} Contenedor con Amazon Linux 2023    		(os-7a-amazon-linux-2023)"
    echo -e "${CYAN}---------------------------------------------------------------------------------${NC}"
    echo -e " ${GREEN}a)${NC} Levantar TODOS los contenedores juntos 		${RED}(ojo!)${NC}"
    echo -e " ${GREEN}b)${NC} Estado de los contenedores 				(docker compose ps)"
    echo -e " ${RED}c)${NC} Detener y eliminar TODOS los contenedores 		${RED}(cuidado)${NC}"
    echo -e " ${RED}d)${NC} Eliminar TODAS las imagenes 			${RED}(cuidado)${NC}"
	echo -e " ${GREEN}e)${NC} Limpiar sistema 					(docker system prune -a)"
    echo -e " ${BLUE_INTENSE}x)${NC} Salir del script 					${BLUE_INTENSE}(exit)${NC}"
    echo -e "${CYAN}=================================================================================${NC}"
    
    read -p "Seleccione una opción [1-13 / a-e / x]: " opcion

    case $opcion in
        1) launch_container "os-1a-alpine" "1a-alpine-3.17" "Alpine Linux 3.17" ;;
        2) launch_container "os-2a-debian-10-buster" "2a-debian-10-buster" "Debian 10 Buster" ;;
        3) launch_container "os-2b-debian-11-bullseye" "2b-debian-11-bullseye" "Debian 11 Bullseye" ;;
        4) launch_container "os-2c-debian-12-bookworm" "2c-debian-12-bookworm" "Debian 12 Bookworm" ;;
        5) launch_container "os-2d-debian-13-trixie" "2d-debian-13-trixie" "Debian 13 Trixie" ;;
        6) launch_container "os-3a-ubuntu-23-04" "3a-ubuntu-23.04" "Ubuntu 23.04 (Lunar Lobster)" ;;
        7) launch_container "os-3b-ubuntu-24-04" "3b-ubuntu-24.04" "Ubuntu 24.04 LTS (Noble Numbat)" ;;
        8) launch_container "os-3c-ubuntu-26-04" "3c-ubuntu-26.04" "Ubuntu 26.04 LTS (Resolute Raccoon)" ;;
        9) launch_container "os-4a-centos-7-9-2009" "4a-centos-7.9.2009" "CentOS 7.9" ;;
        10) launch_container "os-5a-redhat-ubi8" "5a-redhat-ubi8" "RedHat UBI 8.7" ;;
        11) launch_container "os-6a-fedora-39" "6a-fedora-39" "Fedora 39" ;;
        12) launch_container "os-6b-fedora-44" "6b-fedora-44" "Fedora 44" ;;
        13) launch_container "os-7a-amazon-linux-2023" "7a-amazon-linux-2023" "Amazon Linux 2023" ;;
        a)
            echo -e "\n${GREEN}[+] Compilando y levantando TODOS los servicios...${NC}"
            docker compose up -d --build
            echo -e "\n\nPresione Enter para continuar..."
            read -r
            ;;
        b)
            echo -e "\n${GREEN}[i] Estado actual del entorno:${NC}\n"
            docker compose ps
            echo -e "\n\nPresione Enter para continuar..."
            read -r
            ;;
			
        c)
            echo -e "\n${RED}[-] Deteniendo y eliminando contenedores...${NC}"
            docker compose down
            echo -e "\n\nPresione Enter para continuar..."
            read -r
            ;;

        d)
            echo -e "\n${RED}[-] Eliminando todas las imágenes...${NC}"
            docker rmi $(docker images -q)	
            echo -e "\n\nPresione Enter para continuar..."
            read -r
            ;;

        e)
            echo -e "\n${GREEN}[i] Limpiando sistema ...${NC}\n"
            docker system prune -a
            echo -e "\n\nPresione Enter para continuar..."
            read -r
            ;;



        x)
            echo -e "\n${YELLOW}¡Hasta luego!${NC}\n"
            exit 0
            ;;
        *)
            echo -e "\n${RED}[!] Opción inválida. Intente de nuevo.${NC}"
            sleep 1.5
            ;;
    esac
done