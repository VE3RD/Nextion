#!/bin/bash
############################################################
#  Get User ID Database                                    #
#  VE3RD                                      2020-05-20   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
rm user.csv
wget https://database.radioid.net/static/user.csv


# Purpose: Read Comma Separated CSV File
# Author: Vivek Gite under GPL v2.0+
# ------------------------------------------
INPUT=user.csv
OLDIFS=$IFS
IFS=','
cnt=0
cnt2=0

[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

if [ -f /usr/local/etc/stripped.csv ]; then 
	rm /usr/local/etc/stripped.csv 
fi
echo ""
echo "Progress"
while read id call n1 n2 city prov blank country
do
strlen=${id}

	if [ cnt > 1 ] && [ strlen >5 ]; then
		echo "$id,$n1 $n2,$city,$prov,,$country" >> /usr/local/etc/stripped.csv
		((cnt=cnt+1))
	fi
	cnt2=cnt/2000
	BAR='##################################################################################################'   # this is full bar, e.g. 100 chars
    	echo -ne "\r${BAR:0:$cnt2}" # print $i chars of $BAR from 0 position
done < $INPUT
IFS=$OLDIFS
echo ""
echo "Processed $cnt Records"
