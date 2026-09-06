#!/bin/bash
# Pedro Javier Acosta : peteracosta@gmail.com
# List Docker volumes with size in MB (requires sudo)

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


clear
sudo true




### VOLUMES WITH SIZE #######################################
echo -e $LINE_1
echo -e "${C4b}docker volume ls   (with size in MB)${C0}"
DOCKER_VOLUMES=$(docker volume ls -q)

if [ "$DOCKER_VOLUMES" ]; then
    printf "\033[1;34m%-30s %-7s %-18s %-14s %-9s %s\033[0m\n" "VOLUME NAME" "DRIVER" "PROJECT" "CONTAINER" "SIZE(MB)" "MOUNTPOINT"
    for vol in $DOCKER_VOLUMES; do
        name=$(docker volume inspect "$vol" --format '{{.Name}}')
        driver=$(docker volume inspect "$vol" --format '{{.Driver}}')
        project=$(docker volume inspect "$vol" --format '{{if index .Labels "com.docker.compose.project"}}{{index .Labels "com.docker.compose.project"}}{{else if index .Labels "project"}}{{index .Labels "project"}}{{else}}-{{end}}')
        mountpoint=$(docker volume inspect "$vol" --format '{{.Mountpoint}}')
        containers=$(docker ps -a --filter volume="$vol" --format '{{.Names}}' | tr '\n' ',' | sed 's/,$//')
        [ -z "$containers" ] && containers="--"
        size_kb=$(sudo du -s "$mountpoint" 2>/dev/null | cut -f1)
        if [ -n "$size_kb" ] && [ "$size_kb" -gt 0 ]; then
            size_mb=$(awk "BEGIN {printf \"%.2f\", $size_kb/1024}")
        else
            size_mb="0.00"
        fi
        printf "%-30s %-7s %-18s %-14s %-9s %s\n" "$name" "$driver" "$project" "$containers" "$size_mb" "$mountpoint"
    done | sort
else
    echo -e "${C5a}none${C0}"
fi

echo -e $LINE_1