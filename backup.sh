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


# Neispravan unos
neispravan_unos() {
    echo -e "${Red}Neispravan unos, za vise informacija unesite"
    echo -e "$0 -h"
}

# -h tekst
help() {
    echo
    echo -e " ${Green}~+~+~ ${Cyan}BACKUP.sh ${Green}~+~+~ ${NC}"
    echo "Skripta pravi rezervnu kopiju fajlova iz jednog direktorijuma u drugi."
    echo
    echo "Nacin upotrebe: "
    echo "$0 <path_do_originalnog_dir> <path_do_bekapa>"
    echo
}

# Ne sme postojati 3 argumenta ili nijedan

if [ $# -eq 0 ] || [ $# -gt 2 ]; then
    neispravan_unos
    exit 1
fi

if [ "$1" = "-h" ]; then
    help
    exit 0
fi

target=$1
backup=$2

# Da li postoji folder koji zelimo da bekapujemo
if [ -d "$target" ]; then

    # Da li VEC postoji bekapovan folder
    if [ -d "$backup" ]; then
        echo -e "${Yellow}Ovo nije prvi bekap, direktorjium vec postoji!"    
    else
        echo -e "${Green}Prvi bekap, kreiranje direktorijuma!"
        mkdir $backup
    fi
    cp -a $target/. $backup
    
    echo -e "${Green}Uspesno kreirana kopija; Kreiranje izvestaja..."
    touch $backup/report.txt
    echo "[][][][] K R E I R A N   B E K A P [][][][]" >> $backup/report.txt
    date >> $backup/report.txt
    whoami >> $backup/report.txt
    echo "Broj kopiranih fajlova: " >> $backup/report.txt
    ls $target | wc -l >> $backup/report.txt
    echo "Kopirani fajlovi:" >> $backup/report.txt
    ls $target -l >> $backup/report.txt
    

    echo -e "${Green}Bekap kreiran; Za vise informacija proverite report.txt!"

else
    echo -e "${Red}Greska: direktorijum ne postoji!"
fi