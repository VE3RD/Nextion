#!/bin/bash
#################################################
#  Create Last Heard List Log Filefrom 		#
#						#
#						#
#  VE3RD 			2020-05-14	#
#################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

dt=`date '+%Y/%m/%d %H:%M:%S'`
#echo "$dt"

echo "$dt $1 $2 $did" > /home/pi-star/logit.txt
declare -i n

#name=$(sudo sed -n "/$1/p" /usr/local/etc/DMRIds.dat | sed -E "s/[[:space:]]+/|/g" | cut -d'|' -f3 | head -1)
did=$(sudo sed -n "/$1/p" /usr/local/etc/DMRIds.dat | sed -E "s/[[:space:]]+/|/g" | head -1 | cut -d'|' -f1)
list1=$(cat /usr/local/etc/Nextion_Support/lastheardlog.txt | head -19)
echo "$list1" > /usr/local/etc/Nextion_Support/lastheardlog.txt

tac /usr/local/etc/Nextion_Support/lastheardlog.txt > /usr/local/etc/Nextion_Support/lastheardlogtmp.txt
echo "$dt $1 $2 $did" >>  /usr/local/etc/Nextion_Support/lastheardlogtmp.txt 

tac /usr/local/etc/Nextion_Support/lastheardlogtmp.txt > /usr/local/etc/Nextion_Support/lastheardlog.txt
rm /usr/local/etc/Nextion_Support/lastheardlogtmp.txt






