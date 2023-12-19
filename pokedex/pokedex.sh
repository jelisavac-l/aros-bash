#!/bin/bash

# Malo escape karaktera radi estetike
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
NC='\033[0m'              # No color

# -h tekst
help() {
    echo
    echo -e " ${Green}~+~+~ ${Cyan}POKEDEX.sh ${Green}~+~+~ ${NC}"
    echo "Skripta prikazuje slike i podateko o pokemonu."
    echo
    echo "Nacin upotrebe: "
    echo "$0 <ime_pokemona>"
    echo
}

# Neispravan unos
neispravan_unos() {
    echo -e "${Red}Neispravan unos, za vise informacija unesite"
    echo -e "$0 -h"
}

if [ $# = 0 ] || [ $# -gt 1 ]; then
    neispravan_unos
    exit 1
fi

if [ "$1" = "-h" ]; then
    help
    exit 0
fi

curl -s https://raw.githubusercontent.com/msikma/pokesprite/c5aaa610ff2acdf7fd8e2dccd181bca8be9fcb3e/pokemon-gen8/regular/$1.png | viu - -t

# Idemo citanje .csva
cat pokemon.csv | column -t -s, | less -S | grep Name
cat pokemon.csv | column -t -s, | less -S | grep $1