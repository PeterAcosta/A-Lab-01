#!/bin/bash

# Definición de colores para la interfaz en terminal
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # Sin color


# Creamos o sobrescribimos el archivo /test.sh con los comandos y la variable evaluada
cat <<EOF > /usr/local/bin/os-data.sh
#!/bin/bash
echo -e "\nGenerado por el entrypoint.sh del contenedor: ${YELLOW}${THIS_IMAGE}${NC} "
echo -e "Información del sistema:${BLUE}"
cat /etc/os-release
echo -e "${NC}"
figlet "${THIS_IMAGE}"
echo -e ""
neofetch
echo -e ""
EOF

# Asignamos permisos de ejecución al archivo generado
chmod +x /usr/local/bin/os-data.sh

# Esta última línea ejecuta el comando recibido por CMD ("sleep infinity") como PID 1
exec "$@"

