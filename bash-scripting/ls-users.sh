#!/bin/bash
# Peter Acosta : peteracosta@gmail.com
# list USERs & GROUPs order by ID or NAME 

# /etc/passwd format =  username:password:userID:groupID:userInfo:homeDirectory:shell
# /etc/group  format =  group_name:password:group_id:user_list


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




echo -e "\n$C4b L I S T    U S E R S    &    G R O U P S   :$C0 "
echo " ---------------------------------------------------"
echo " 1) List USERs   (file /etc/passwd sort by UID)"
echo " 2) List USERs   (file /etc/passwd sort by USERNAME)"
echo " "
echo " 3) List GROUPs  (order by GID)"
echo " 4) List GROUPs  (order by NAME)"
echo " "
echo " 5) List USERs in their GROUPs (order by UID)"
echo " 6) List USERs in their GROUPs (order by USERNAME)"
echo " "
read -p " Enter an option ( 0 to exit )  : " option > /dev/null
echo " you chose: $option \n \n"

 


if [ "$option" = "1" ]
    then
        # 1) List USERS  (order by UserID)
        clear
        FILE_NAME='/etc/passwd'
        GREP_FILE=$(cat $FILE_NAME | grep -v '^$')
        LINES1=$(echo "$GREP_FILE" | wc -l)
        LINES2=$(cat $FILE_NAME | wc -l)
        LINES_EMPTY=$(( LINES2 -LINES1 ))
        CANT="$C1$LINES1 users $C0 "
        if [ "$LINES_EMPTY" -gt 0 ]; then
            CANT="$CANT $C3a**(warning $LINES_EMPTY empty lines in the file)$C0"
        fi
        TITLE=' UID      USERNAME              P  GID     UserInfo                                      home                      shell'
        UNDER=' -------  --------------------  -  ------- --------------------------------------------  ------------------------  -------------------------'
        echo -e "$C4b U S E R S  : $C0 file  $FILE_NAME  (sorted by UserID):  $CANT\n\n$C4a$TITLE\n$UNDER$C0"
        echo -e "$GREP_FILE" | awk -F: '{ printf " %-7s  %-20s  %1s  %-7s %-45s %-25s %-20s \n",$3,$1,$2,$4,$5,$6,$7 }' | sort -n 
        echo -e "$C4a$UNDER\n$TITLE$C0\n"
        exit 0


elif [ "$option" = "2" ]
    then
        # 2) List USERS  (order by USERNAME)"
        clear
        FILE_NAME='/etc/passwd'
        GREP_FILE=$(cat $FILE_NAME | grep -v '^$')
        LINES1=$(echo "$GREP_FILE" | wc -l)
        LINES2=$(cat $FILE_NAME | wc -l)
        LINES_EMPTY=$(( LINES2 -LINES1 ))
        CANT="$C1$LINES1 users $C0 "
        if [ "$LINES_EMPTY" -gt 0 ]; then
            CANT="$CANT $C3a**(warning $LINES_EMPTY empty lines in the file)$C0"
        fi
        TITLE=' USERNAME              UID      P  GID      UserInfo                                      home                      shell'
        LINEX=' --------------------- -------  -  -------  --------------------------------------------  ------------------------  -------------------------'
        echo -e "$C4b U S E R S  : $C0 file  $FILE_NAME  (sorted by USERNAME):  $CANT\n\n$C4a$TITLE\n$LINEX$C0"
        echo -e "$GREP_FILE" | awk -F: '{printf " %-20s  %-7s  %1s  %-7s  %-45s %-25s %-20s \n",$1,$3,$2,$4,$5,$6,$7 }' | sort -k 1
        echo -e "$C4a$LINEX\n$TITLE$C0\n"
        exit 0


elif [ "$option" = "3" ]
    then
        # 3) List GROUPS  (order by GroupID)
        clear
        FILE_NAME='/etc/group'
        GREP_FILE=$(cat $FILE_NAME | grep -v '^$')
        LINES1=$(echo "$GREP_FILE" | wc -l)
        LINES2=$(cat $FILE_NAME | wc -l)
        LINES_EMPTY=$(( LINES2 -LINES1 ))
        CANT="$C1$LINES1 groups $C0 "
        if [ "$LINES_EMPTY" -gt 0 ]; then
            CANT="$CANT $C3a**(warning $LINES_EMPTY empty lines in the file)$C0"
        fi
        TITLE=" GID      GROUP NAME            P  Users"
        LINEX=" -------- --------------------- -  --------------------------------"
        echo -e "$C4b G R O U P S  : $C0 file  $FILE_NAME  (sorted by GroupID):  $CANT\n\n$C4a$TITLE\n$LINEX$C0"
        echo -e "$GREP_FILE" | awk -F: '{printf " %-7s  %-20s  %1s  %-30s \n",$3,$1,$2,$4 }' | sort -n 
        echo -e "$C4a$LINEX\n$TITLE$C0\n"
        exit 0


elif [ "$option" = "4" ]
    then
        # 4) List GROUPS  (order by GROUP NAME)
        clear
        FILE_NAME='/etc/group'
        GREP_FILE=$(cat $FILE_NAME | grep -v '^$')
        LINES1=$(echo "$GREP_FILE" | wc -l)
        LINES2=$(cat $FILE_NAME | wc -l)
        LINES_EMPTY=$(( LINES2 -LINES1 ))
        CANT="$C1$LINES1 groups $C0 "
        if [ "$LINES_EMPTY" -gt 0 ]; then
            CANT="$CANT $C3a**(warning $LINES_EMPTY empty lines in the file)$C0"
        fi
        TITLE=" GROUP NAME            GID      P  Users"
        LINEX=" --------------------- -------- -  --------------------------------"
        echo -e "$C4b G R O U P S  : $C0 file  $FILE_NAME  (sorted by GROUP NAME):  $CANT\n\n$C4a$TITLE\n$LINEX$C0"
        echo -e "$GREP_FILE" | awk -F: '{printf " %-20s  %-7s  %1s  %-30s \n",$1,$3,$2,$4 }' | sort 
        echo -e "$C4a$LINEX\n$TITLE$C0\n"
        exit 0



elif [ "$option" = "5" ]
    then
        # 5) List users in their groups order by UserID
        clear
        FILE_NAME='/etc/passwd'
        GREP_FILE=$(cat $FILE_NAME | grep -v '^$'| sort -t: -k3n)
        TITLE=' UID      USERNAME              GID      Groups'
        LINEX=' -------  --------------------- -------  -------------------------------------------------------------------------------------'
        echo -e "$C4b U S E R S   I N   T H E I R   G R O U P S  $C0 (sorted by UserID):\n\n$C4a$TITLE\n$LINEX$C0"
        echo -e "$GREP_FILE" | while IFS=: read -r username password uid gid info home shell; do
            if [ -n "$username" ]; then
                printf " %-7s  %-20s  %-7s " $uid $username $gid
                XGROUPS="$(id $uid | cut -d '=' -f 4 | sed 's#(#:#g' | sed 's#)# #g'| sed 's#,# #g')"               
                NCOL=$C0
                for ngr in $XGROUPS; do
                    echo -n -e "$NCOL $ngr "
                    NCOL=$C9b
                done
                echo -e "$C0"
            fi
        done 
        echo -e "$C4a$LINEX\n$TITLE$C0\n"
        exit 0


elif [ "$option" = "6" ]
    then
        # 6) List users in their groups order by USERNAME
        clear
        FILE_NAME='/etc/passwd'
        GREP_FILE=$(cat $FILE_NAME | grep -v '^$'| sort -t: -k1n)
        TITLE=' USERNAME              UID      GID      Groups'
        LINEX=' --------------------- -------  -------  ------------------------------------------------------------------------------------'
        echo -e "$C4b U S E R S   I N   T H E I R   G R O U P S  $C0 (sorted by USERNAME):\n\n$C4a$TITLE\n$LINEX$C0"
        echo -e "$GREP_FILE" | while IFS=: read -r username password uid gid info home shell; do
            if [ -n "$username" ]; then
                printf " %-20s  %-7s  %-7s " $username $uid $gid
                XGROUPS="$(id $uid | cut -d '=' -f 4 | sed 's#(#:#g' | sed 's#)# #g'| sed 's#,# #g')"               
                NCOL=$C0
                for ngr in $XGROUPS; do
                    echo -n -e "$NCOL $ngr "
                    NCOL=$C9b
                done
                echo -e "$C0"
            fi
        done 
        echo -e "$C4a$LINEX\n$TITLE$C0\n"
        exit 0


elif [ "$option" = "0" ]
    then
        #0 Exit
        echo -e " Bye bye.... adios\n"
        exit 0


else

    echo -e "[ $option ] Opción invalida.   :(\n"

fi
