#!/bin/bash
# Pedro Javier Acosta : peteracosta@gmail.com
# my color codes for my bash files @ debian-ubuntu-mint 


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


LINE1="// 0123456789. abcdefghijklmnopqrstuvwxyz // -------------------------------------- // ====================================== //"

clear
echo -e "\n Colors : my color codes for my bash files @ debian-ubuntu-mint\n"

echo -e "$C0\$C0 : default \t\t code : '\\$C0'"
echo -e $LINE1
echo 

echo -e "$C1a\$C1a : red \t\t code : '\\$C1a'"
echo -e $LINE1
echo -e "$C1b\$C1b : bold red \t code : '\\$C1b'"
echo -e $LINE1
echo " "

echo -e "$C2a\$C2a : green \t\t code : '\\$C2a'"
echo -e $LINE1
echo -e "$C2b\$C2b : bold green \t code : '\\$C2b'"
echo -e $LINE1
echo " "

echo -e "$C3a\$C3a : yellow \t\t code : '\\$C3a'"
echo -e $LINE1
echo -e "$C3b\$C3b : bold yellow \t code : '\\$C3b'"
echo -e $LINE1
echo " "

echo -e "$C4a\$C4a : blue \t\t code : '\\$C4a'"
echo -e $LINE1
echo -e "$C4b\$C4b : bold blue \t code : '\\$C4b'"
echo -e $LINE1
echo " "

echo -e "$C5a\$C5a : purple \t\t code : '\\$C5a'"
echo -e $LINE1
echo -e "$C5b\$C5b : bold purple \t code : '\\$C5b'"
echo -e $LINE1
echo " "

echo -e "$C6a\$C6a : cyan \t\t code : '\\$C6a'"
echo -e $LINE1
echo -e "$C6b\$C6b : bold cyan \t code : '\\$C6b'"
echo -e $LINE1
echo " "

echo -e "$C7a\$C7a : light gray \t code : '\\$C7a'"
echo -e $LINE1
echo -e "$C7b\$C7b : bold light gray \t code : '\\$C7b'"
echo -e $LINE1
echo " "

echo -e "$C9a\$C9a : dark gray \t code : '\\$C9a'"
echo -e $LINE1
echo -e "$C9b\$C9b : bold dark gray \t code : '\\$C9b'"
echo -e $LINE1
echo " "

echo -e $C0
exit 0