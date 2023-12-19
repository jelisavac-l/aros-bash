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
    echo -e " ${Green}~+~+~ ${Cyan}POENI.sh ${Green}~+~+~ ${NC}"
    echo "Skripta za evidentiranje poena koje su studenti ostvarili javljanjem na casu."
    echo
    echo "Nacin upotrebe: "
    echo "javio <arg>"
    echo 
    echo "Lista argumenata:"
    echo -e "${Cyan} se${NC} \t upis novog studenta"
    echo -e "${Cyan} -l${NC} \t ispis broja javljanja svakog studenta"
    echo -e "${Cyan} -r${NC} \t brisanje sadrzaja baze javljenih studenata"
    echo
}

# Neispravan unos
neispravan_unos() {
    echo -e "${Red}Neispravan unos, za vise informacija unesite"
    echo -e "$0 -h"
}

# Litanje evidentiranih studenata
izlistaj() {

    # Provera da li lista.info postoji
    if [ ! -f "./lista.info" ]; then
        echo -e "${Red}Datoteka sa evidencijom ne postoji!"
        exit 0
    fi

    # Ako smislim nesto vremenski efikasnije, izmenicu
    sort "./lista.info" | uniq -c | sort -nr
}

if [ $# -eq 0 ] || [ $# -gt 1 ]; then
    neispravan_unos
    exit 1
fi

if [ "$1" = "-h" ]; then
    help
    exit 0
fi

case $1 in

  se)
    echo "Unesite ime i prezime studenta"
    read ime_prezime
    echo "Unesite broj indeksa u formatu 2022/0554"
    read ndx
    echo -e "$ime_prezime\t$ndx" >> lista.info # Ne moramo prethodno da napravimo fajl. Ako ne postoji, ovde se automatski pravi
    echo -e "Uspesno evidentirana aktivnost studenta: ${Green}$ime_prezime ($ndx)"
    ;;

  -l)
  echo -e "${Yellow}Izlistavanje svih studenata koji su bili aktivni tokom ovog predavanja${Green}"
    izlistaj
    ;;

  -r) # Jedno ne toliko kreativno resenje
    > "./lista.info"
    echo "Uspesno obrisan spisak aktivnosti!"

    ;;

  *)
    neispravan_unos
    ;;
esac
