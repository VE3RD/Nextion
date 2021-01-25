#!/bin/bash
############################################################
#  Get User ID Database                                    #
#  VE3RD                                      2020-05-20   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

if [ -f user.csv ]; then
rm user.csv
echo ""
fi
wget https://database.radioid.net/static/user.csv


# Purpose: Read Comma Separated CSV File
# Author: Vivek Gite under GPL v2.0+
# ------------------------------------------
INPUT=user.csv
OLDIFS=$IFS
IFS=','
declare -i cnt=0
declare -i cnt2=0
declare -i lc=0
declare -i tmp=1

lc=$(wc -l < user.csv)

[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

if [ -f /usr/local/etc/stripped.csv ]; then 
	rm /usr/local/etc/stripped.csv 
fi
echo ""
echo "Progress - Converting File Format"

while read id call n1 n2 city prov blank country
do
	strlen=${id}
	((cnt=cnt+1))	

	if [ $cnt > 1 ] && [ $strlen > 5 ]; then
		echo "$id,$call,$n1 $n2,$city,$prov,,$country" >> /usr/local/etc/stripped.csv
	fi

	tmp=$((lc/100))
	cnt2=$((cnt / tmp ))

	BAR='##################################################################################################'   # this is full bar, e.g. 100 chars
    	echo -ne "\r${BAR:0:$cnt2}" "$cnt2%"  # print $i chars of $BAR from 0 position
done < $INPUT
IFS=$OLDIFS
echo ""
echo "Processed $cnt Records"
sudo mount -o remount,ro /
