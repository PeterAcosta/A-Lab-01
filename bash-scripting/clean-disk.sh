#!/bin/bash
# Script de limpieza para Ubuntu
# Autor: Peter (adaptado para tu servidor)
# Uso: sudo ./clean-disk.sh

# my color codes :
C0="\e[0m"       # default
C1a="\e[0;31m"   # red
C1b="\e[1;31m"   # bold red
C2a="\e[0;32m"   # green
C2b="\e[1;32m"   # bold green
C3a="\e[0;33m"   # yellow
C3b="\e[1;33m"   # bold yellow
C4a="\e[0;34m"   # blue
C4b="\e[1;34m"   # bold blue
C5a="\e[0;35m"   # purple
C5b="\e[1;35m"   # bold purple
C6a="\e[0;36m"   # cyan
C6b="\e[1;36m"   # bold cyan
C7a="\e[0;37m"   # light gray
C7b="\e[1;37m"   # bold light gray
C9a="\e[0;90m"   # dark gray
C9b="\e[1;90m"   # bold dark gray
clear

echo -e "$C4b🔹 Iniciando limpieza de disco en $(hostname) :$C0"
echo ""

# --- FUNCIONES ---
get_disk_usage() {
    # Devuelve uso de disco en KB
    df --output=used,size,avail -k / | tail -1
}

format_human() {
    # Convierte KB a formato legible (GB/MB)
    num=$1
    if [ $num -lt 1024 ]; then
        echo "${num} KB"
    elif [ $num -lt 1048576 ]; then
        echo "$((num/1024)) MB"
    else
        echo "$((num/1048576)) GB"
    fi
}

# --- ESTADO INICIAL ---
read USED_BEFORE SIZE_BEFORE AVAIL_BEFORE <<< $(get_disk_usage)

echo -e "$C4b📊 Estado inicial del disco raíz (/):$C0"
echo "   Capacidad total : $(format_human $SIZE_BEFORE)"
echo "   Ocupado         : $(format_human $USED_BEFORE)"
echo "   Libre           : $(format_human $AVAIL_BEFORE)"
echo ""

# 1. Actualizar índices
echo -e "$C4b🔹 Actualizando índices de paquetes...$C0"
sudo apt-get update -qq
echo ""


# 2. Limpiar caché de APT
echo -e "$C4b🔹 Limpiando caché de APT...$C9a"
sudo apt-get clean
sudo apt-get autoclean -y
echo ""

# 3. Eliminar paquetes huérfanos
echo -e "$C4b🔹 Eliminando paquetes huérfanos...$C9a"
sudo apt-get autoremove -y
echo ""

# 4. Borrar caché del usuario y papelera
echo -e "$C4b🔹 Limpiando cachés y papelera de usuario...$C0"
rm -rf ~/.cache/*
rm -rf ~/.local/share/Trash/*
echo ""

# 5. Borrar miniaturas almacenadas
echo -e "$C4b🔹 Limpiando thumbnails...$C0"
rm -rf ~/.thumbnails/*
rm -rf ~/.cache/thumbnails/*
echo ""

# 6. Limpiar logs de systemd (solo últimos 7 días)
echo -e "$C4b🔹 Limpiando logs de systemd...$C9a"
sudo journalctl --vacuum-time=7d
echo ""

# 7. Opcional: borrar logs comprimidos antiguos en /var/log
echo -e "$C4b🔹 Borrando logs antiguos en /var/log...$C0"
sudo find /var/log -type f -name "*.gz" -delete
sudo find /var/log -type f -name "*.old" -delete
echo ""

# --- ESTADO FINAL ---
read USED_AFTER SIZE_AFTER AVAIL_AFTER <<< $(get_disk_usage)

# Cálculo de liberado
FREED=$((USED_BEFORE - USED_AFTER))

echo ""
echo -e "$C4b✅ Estado final del disco raíz (/):$C0"
echo "   Capacidad total : $(format_human $SIZE_AFTER)"
echo "   Ocupado         : $(format_human $USED_AFTER)"
echo "   Libre           : $(format_human $AVAIL_AFTER)"
echo -e "$C9a   ➝ [Espacio liberado: $(format_human $FREED)]$C0"
echo ""
echo ""
echo -e "$C4b🚀 Limpieza finalizada.$C0"
