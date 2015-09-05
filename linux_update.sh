    #!/bin/bash
    export BLUE="\033[1;94m"
    export GREEN="\033[1;92m" 
    export RED="\e[0;31m"
    export NORMAL="\033[1;00m"
    control() {
        if [ "$1" = "" ]; then
            return 0
        else
            if [ "$1" != -u -a "$1" != --upgrade -a "$1" != -d -a "$1" != --dist-upgrade ]; then
                return 1
            else 
                return 0
            fi
        fi
    }
    help() {        
echo "\nUso: ./linux_update [opzioni]     

Opzioni:
        -h, --help          Mostra questa schermata ed esce
        -u, --upgrade       Aggiorna i pacchetti
        -d, --dist-upgrade  Aggiorna il sistema operativo\n" 
        exit 1
    }
    update() {
        apt-get update
    }
    upgrade() {
        if [ "$1" = -u -o "$1" = --upgrade -o "$2" = -u -o "$2" = --upgrade ]; then
            apt-get -y upgrade
	    fi    
    }
    dist_upgrade() {
    	if [ "$1" = -d -o "$1" = --dist-upgrade -o "$2" = -d -o "$2" = --dist-upgrade ]; then
            apt-get -y dist-upgrade
	    fi    
    }
    if [ `id -u` -eq 0 ]; then
        echo "$GREEN
------------------------------        
|linux_update 0.3            |
|designed for linux          |
|coded by emanuele forestieri|
------------------------------$NORMAL"
        control "$1" && control "$2" && control "$3"
        CONTROL=$?
        if [ "$#" -lt 1 -o "$1" = -h -o "$1" = --help -o "$CONTROL" -eq 1 ]; then
            help
        else
            echo "\n$BLUE[*] Aggiornamenti in corso...$NORMAL\n"
            update
            upgrade "$1" "$2"
            dist_upgrade "$1" "$2"
            echo "\n$BLUE[+] Aggiornamenti completati!\n"
        fi
    else
        echo -e "$RED[!] linux_update deve essere eseguito come root!"
    fi
    exit 0
