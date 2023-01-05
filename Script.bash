#!/bin/bash

help()
{
	echo "-lmem :     pour afficher les informations en relation avec la memoire"
	echo "-lpart :    afficher les informations en relation avec les partions du disque"
	echo "-lkernel :  afficher la version dd noyau linux"
}
menu(){
	echo "1- la commande lmem"
	echo "2- la commande lpart"
	echo "3- la commande lkernel"
	echo "4- help"
	echo "5- save"
	echo "0- exit"
}
save(){
cat /proc/meminfo >> /var/sujet8/$s
cat /proc/partitions >> /var/sujet8/$s
cat /proc/version >> /var/sujet8/$s
}
lmem(){

 cat /proc/meminfo

}

lpart(){
cat /proc/partitions
}
lkernel(){
cat /proc/version
}



menuu()
{
while true
do
menu
read input

case $input in
1) lmem
;;
2) lpart
;;
3) lkernel
;;
4) help
;;
5) d=`date +%d-%m-%y`
   s="$OPTARG-$d"
   save $s
;;
0) exit
;;
*) echo "choix invalid"
;;
esac
 
done
}



yadd(){
files=$(yad --width 100 --height 100 --title "shell sujet 8" \
	--text="choisir une option" \
	--button="info memoire:1" \
	--button="info partition:2" \
	--button="version noyau:3" \
	--button="help:4" \
	--button="exit:5" \
	--on-top \
	--center \

)

ret=$?
[[ $ret -eq 5 ]] && exit 0
	case $ret in
		1)mm=$(yad --width 100 --height 100 --title "shell sujet 8" \
		--text= lmem \
		)
		;;
		2)lpart
		;;
		3)lkernel
		;;
		4)help
		;;
esac
}
while getopts "empkhgs:" option
 do

	case $option in
		e)lmem
		;;
		p)lpart
		;;
		k)lkernel
		;;
		h) help
		;;
		s)
		d=`date +%d-%m-%y`
		s="$OPTARG-$d"
		save $s
		;;
		m)menuu
		;;
		g)yadd
		;;
		*) echo "error"
		;;
		esac
done
