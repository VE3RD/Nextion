#!/bin/bash
############################################################
#  Lookup YSF Host /usr/local/etc/YSFHosts.txt 		   #
#  Return Multi-Parameter String                           #
#                                                          #
#                                                          #
#  VE3RD                                      2020-01-11   #
############################################################
set -o errexit
set -o pipefail
# Use passed DMR Master name to lookup IP address
declare LEN number
if [ -z "$1" ]; then
	echo " Insufficient Number of Parameters "
	exit
fi
typeset -u str="$1"

	mts=$(sudo sed -n '/'"$str"'/p' /usr/local/etc/YSFHosts.txt | sed -r 's/[;]+/|/g' | head -1)
#echo "mts -- $mts"
	mt1=$(echo "$mts" | cut -d'|' -f1)
	mt2=$(echo "$mts" | cut -d'|' -f2)
	mt3=$(echo "$mts" | cut -d'|' -f3)
	mt4=$(echo "$mts" | cut -d'|' -f4)
	mt5=$(echo "$mts" | cut -d'|' -f5)
	mt6=$(echo "$mts" | cut -d'|' -f6)
	mt7=$(echo "$mts" | cut -d'|' -f7)
	mt="$mt1|$mt3|$mt4|$mt5"

if [ -z "$2" ]; then
	echo "$mt"
else

    case "$2" in
 	"1") 
		echo "$mt1";;
	"2")
		echo "$mt2";;
	"3")
		echo "$mt3";;
	"4")
		echo "$mt4";;
	"5")
		echo "$mt5";;
	"6")
		echo "$mt6";;
	"7")
		echo "$mt7";;

     esac
fi
