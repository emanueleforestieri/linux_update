#!/bin/bash
#  
#  Copyright 2015 Emanuele Forestieri <forestieriemanuele@gmail.com>
#  Copyright 2015 Matteo Alessio Carrara <sw.matteoac@gmail.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#

#text colors
export BLUE='\033[1;94m'
export GREEN='\033[1;92m' 
export RED='\e[0;31m'
export NORMAL='\033[1;00m'


err_echo () #echo on stderr
{
	>&2 echo -e "$*"
} 

err ()
{
	err_echo $RED"[!] "$*$NORMAL
}

inf ()
{
	err_echo $BLUE"[*] "$*$NORMAL
}

ok ()
{
	err_echo $BLUE"[+] "$*$NORMAL
}

control () #check argv
{
	for arg
	do
		if [ "$arg" = "-h" -o "$arg" = "--help" ]; then export h="TRUE";
		elif [ "$arg" = "-u" -o "$arg" = "--upgrade" ]; then export u="TRUE"; 
		elif [ "$arg" = "-d" -o "$arg" = "--dist-upgrade" ]; then export d="TRUE";
		else help
		fi   
	done
}

help()
{
	err_echo "Uso: "$0" [opzioni]\n" 
	err_echo "Opzioni:"
	err_echo "-h, --help          Show this screen and exit"
	err_echo "-u, --upgrade       Upgrades packages"
	err_echo "-d, --dist-upgrade  Upgrade your operating system\n"
	exit 1
}


ARGC="$#"

if [ $ARGC -eq 0 ]
then
	help
else
	control $*
	if [ -n "$h" ] || [ -z "$u" ] && [ -z "$d" ]; then help; fi
	if [ `id -u` -eq 0 ] #if it is run as root
	then
		inf "Ongoing updates..."
		apt-get update
		if [ $u ]; then apt-get -y upgrade; fi
		if [ $d ]; then apt-get -y dist-upgrade; fi
		if [ $? -eq 0 ]; then ok "Successful updates!"; fi
	else
		err "This script must be run as root!"
		exit 1
	fi	
fi

exit 0
