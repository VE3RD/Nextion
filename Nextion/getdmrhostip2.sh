#!/bin/bash
############################################################
#  Lookup DMR Host in /usr/local/etc/DMR_Hosts.txt         #
#  Return IP Address.                                      #
#                                                          #
#                                                          #
#  VE3RD                                        2019-01-11 #
############################################################
set -o errexit
set -o pipefail
# Use passed DMR Master name to lookup IP address
declare LEN number

if [ -z "$1" ]; then
	HN=$(sudo /usr/local/etc/Nextion_Support/getmaster.sh)
else
	HN="$1"
fi
fromfile=/usr/local/etc/Nextion_Support/profiles.txt

mt=$(sudo sed -n '/^[^#]*'"$HN"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g")

mt1=$( echo "$mt" | cut -d'|' -f1)
#mt2=$( echo "$mt" | cut -d'|' -f2)
mt3=$( echo "$mt" | cut -d'|' -f3)
mt4=$( echo "$mt" | cut -d'|' -f4)
mt5=$( echo "$mt" | cut -d'|' -f5)

mt2=$(sed -nr "/^\[Profile 0\]/ { :l /^ExtId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)

if [ -z $mt ]; then
	echo "Nothing|Found|Try|Another|Search"
else
	echo "$mt1|$mt2|$mt3|$mt4|$mt5"

fi

