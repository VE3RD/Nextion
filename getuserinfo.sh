#!/bin/bash
#################################################
#  Get User Info from User ID     		#
#						#
#						#
#  VE3RD 			2020-11-19	#
#################################################
set -o errexit
set -o pipefail

if [ -z "$1" ]; then
	exit
fi
sudo mount -o remount,rw /
echo "Param $1" >  /home/pi-star/userinfo.txt 

fname="/usr/local/etc/stripped.csv"
uid="$1"

#info=$(sudo sed -n '/^[^#]*\t'"$1"'/p' "$fname" | sed -E "s/[[:space:]]+/|/g" | head -1)
info=$(sudo sed -n '/^[^#]*'"$1"'/p' /usr/local/etc/stripped.csv)
info1=$(sudo sed -n '/^[^#]*'"$1"'/p' /usr/local/etc/DMRIds.dat)

#@info=$(grep "$1" /usr/local/etc/Nextion_Support/user.txt)
#echo "$infostr"

mt1=$( echo "$info" | cut -d',' -f1)
mt2=$( echo "$info" | cut -d',' -f2)
#mt3=$( echo "$info1" | cut -d$'\t' -f3)
mt3=$( echo "$info" | cut -d',' -f3)
mt4=$( echo "$info" | cut -d',' -f4)
mt5=$( echo "$info" | cut -d',' -f5)
mt6=$( echo "$info" | cut -d',' -f6)
mt7=$( echo "$info" | cut -d',' -f7)

echo "$mt2,$mt3,$mt5,$mt6,$mt7"

echo "$mt2,$mt3,$mt5,$mt6,$mt7,$1" >> /home/pi-star/userinfo.txt
sudo mount -o remount,ro /

	
