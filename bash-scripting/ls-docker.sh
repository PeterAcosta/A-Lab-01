#!/bin/bash
# Pedro Javier Acosta : peteracosta@gmail.com
# list states and properties of docker objects, containers, images, volumes and networks

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


LINE_1="$C4a-------------------------------------------------------------------------------------------------------------------------------------$C0"
LINE_2="$C4a- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -$C0"



DOCKER_PS_AQ=$(docker ps -aq)
DOCKER_PS_RUNNING=$(docker ps -q --filter status=running )
DOCKER_PS_EXITED=$(docker ps  -q --filter status=exited  )

clear

### DISK ###################################################
echo -e $LINE_1
echo -ne "${C4b}uptime   ${C0}"
awk '{printf "OS\tUp   : %dd %02dh %02dm %02ds\n", $1/86400, ($1%86400)/3600, ($1%3600)/60, $1%60}' /proc/uptime
echo -ne "${C4b}df -h    ${C0}"
df -h / | tail -1 | awk '{print "Disk \tTotal: " $2 " \tUsed: " $3 " \tFree: " $4 " \t" $5 " used"}'
echo -ne "${C4b}free -h  ${C0}"
free | grep Mem | awk '{printf "Mem \tTotal: %.1fG \tUsed: %.1fG \tFree: %.1fG \t%.0f%% used\n", $2/1024/1024, $3/1024/1024, $7/1024/1024, ($3/$2)*100}'


### MEMORY #################################################
# echo -e $LINE_2
# echo -e "${C4b}free -m -h$C0" 
# free -m -h


### STATS  #################################################
echo -e $LINE_1
echo -e "${C4b}docker stats --no-stream  $C0"
docker stats --no-stream



### RUNNING  ################################################
echo -e "$LINE_1"
echo -e "${C4b}CONTAINER RUNNING	${C4a}(docker ps --filter status=running):$C0"
if [ "$DOCKER_PS_RUNNING" ]; then
    docker ps --filter status=running --format 'table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}\t{{.Size}}\t{{.Ports}}' | cut -c1-$(tput cols)
else
    echo -e "${C5a}none $C0"
fi


### EXITING  ###############################################
echo -e $LINE_2
echo -e "${C4b}CONTAINER STOPPED	${C4a}(docker ps --filter status=exited) :$C5a"
if [ "$DOCKER_PS_EXITED" ] ; then
    docker ps --filter status=exited --format 'table {{ .Names }}\t{{ .ID }}\t{{.Image}}\t{{.Command}}\t{{.Size}}\t{{.RunningFor}}\t{{.Status}}'
else
    echo -e "${C5a}none $C0"
fi


### LIST ALL CONTAINERS  ####################################
echo -e $LINE_2
echo -e "${C4b}docker ps -a  $C9a" 
docker ps -a | cut -c1-$(tput cols)
echo -e -n $C0







### IMAGES  #################################################
echo -e $LINE_1
echo -e "${C4b}docker images  $C0"
# docker images
# (docker images | head -1; docker images | tail -n +2 | sort)
( docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedSince}}\t{{.Size}}" | head -1 ; \
  docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedSince}}\t{{.Size}}" | tail -n +2 | sort )



### IPs & RESTART  ##########################################
echo -e $LINE_1
if [ "$DOCKER_PS_AQ" ] ; then
    docker inspect -f '{{.Name}} %tab% {{.ID}} %tab% {{range $net,$conf := .NetworkSettings.Networks}}{{$net}} %tab% {{.IPAddress}}{{end}} %tab% {{.RestartCount}}' $DOCKER_PS_AQ |  \
        sed 's#%tab%#\t#g' |  \
        awk '{print $1, substr($2, 1, 12),  $3, $4, $5}' |  \
        sed 's#/##g' |  \
        sort |  \
        column -t -o "   " -N "CONTAINER NAME,CONTAINER ID,NETWORK,IP,RESTART" |  \
        awk 'NR==1 {print "\033[1;34m" $0 "\033[0m"} NR>1'
fi





### VOLUMES #################################################
# echo -e $LINE_1
# echo -e "${C4b}docker volume ls  $C0"
# docker volume ls 



### VOLUMES #################################################
echo -e $LINE_1
echo -e "${C4b}docker volume ls (detailed)  $C0"
DOCKER_VOLUMES=$(docker volume ls -q)
if [ "$DOCKER_VOLUMES" ]; then
    {
        echo -e "\033[1;34mVOLUME NAME%tab%DRIVER%tab%PROJECT%tab%CONTAINER%tab%MOUNTPOINT\033[0m"
        for vol in $DOCKER_VOLUMES; do
            # Obtener información básica del volumen
            name=$(docker volume inspect "$vol" --format '{{.Name}}')
            driver=$(docker volume inspect "$vol" --format '{{.Driver}}')
            project=$(docker volume inspect "$vol" --format '{{if index .Labels "com.docker.compose.project"}}{{index .Labels "com.docker.compose.project"}}{{else if index .Labels "project"}}{{index .Labels "project"}}{{else}}-{{end}}')
            mountpoint=$(docker volume inspect "$vol" --format '{{.Mountpoint}}')
            
            # Ver qué contenedores usan este volumen
            containers=$(docker ps -a --filter volume="$vol" --format '{{.Names}}' | tr '\n' ',' | sed 's/,$//')
            if [ -z "$containers" ]; then
				containers="${C9a}orphan $C0"
            fi
            
            echo -e "${name}%tab%${driver}%tab%${project}%tab%${containers}%tab%${mountpoint}"
        done | sort
    } | sed 's/%tab%/\t/g' | column -t -s $'\t'
else
    echo -e "${C5a}none $C0"
fi







### NETWORK #################################################
echo -e $LINE_1
echo -e "${C4b}docker network ls (detailed)  $C0"
DOCKER_NETWORKS=$(docker network ls -q)
if [ "$DOCKER_NETWORKS" ]; then
    {
        echo -e "\033[1;34mNETWORK NAME%tab%NETWORK ID%tab%DRIVER%tab%SCOPE%tab%PROJECT%tab%SUBNET%tab%CONTAINERS\033[0m"
        for net in $DOCKER_NETWORKS; do
            # Obtener información de la red
            name=$(docker network inspect "$net" --format '{{.Name}}')
            id=$(docker network inspect "$net" --format '{{.Id}}' | cut -c1-12)
            driver=$(docker network inspect "$net" --format '{{.Driver}}')
            scope=$(docker network inspect "$net" --format '{{.Scope}}')
            
            # Obtener project
            project=$(docker network inspect "$net" --format '{{if index .Labels "com.docker.compose.project"}}{{index .Labels "com.docker.compose.project"}}{{else if index .Labels "project"}}{{index .Labels "project"}}{{else}}-{{end}}')
            
            # Obtener subnet
            subnet=$(docker network inspect "$net" --format '{{range .IPAM.Config}}{{.Subnet}}{{end}}')
            [ -z "$subnet" ] && subnet="-"
            
            # Obtener contenedores conectados
            containers=$(docker network inspect "$net" --format '{{range $key, $value := .Containers}}{{$value.Name}},{{end}}' | sed 's/,$//')
            [ -z "$containers" ] && containers="-"
            
            echo -e "${name}%tab%${id}%tab%${driver}%tab%${scope}%tab%${project}%tab%${subnet}%tab%${containers}"
        done | sort
    } | sed 's/%tab%/\t/g' | column -t -s $'\t'
else
    echo -e "${C5a}none $C0"
fi




echo -e $LINE_1


