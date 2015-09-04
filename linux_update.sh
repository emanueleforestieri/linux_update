    #!/bin/bash
    export BLUE='\033[1;94m'
    export GREEN='\033[1;92m' 
    export RED='\e[0;31m'
    export NORMAL='\033[1;00m'
    control() {
        if [ "$1" != -u -a "$1" != --upgrade -a "$1" != -d -a "$1" != --dist-upgrade ]; then
            return 1
        else 
            return 0
        fi
    }
    help() {
        echo "
Uso: ./linux_update [opzioni]     

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
        ARGC="$#"
        if [ "$ARGC" -lt 2 ]; then
            control "$1"
            CONTROL=$?
        else
            control "$1" && control "$2"
            CONTROL=$?
        fi
        if [ "$#" -lt 1 -o "$1" = -h -o "$1" = --help -o "$CONTROL" -eq 1 ]; then
            help
        else
            echo "$BLUE[*] Aggiornamenti in corso...$NORMAL"
            update
            upgrade "$1" "$2"
            dist_upgrade "$1" "$2"
            echo "$BLUE[+] Aggiornamenti completati!"
        fi
    else
        echo -e "$RED[!] linux_update deve essere eseguito come root!"
    fi
    exit 0

