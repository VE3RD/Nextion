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
#'/^#/!s/

mt=$(sudo sed -n '/^[^#]*'"$HN"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g")
#mt1=$(sudo sed -n '/^[^#]*'"$HN"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g" | cut -d'|' -f3)
#echo "$mt1"
#mt=$(sudo sed -n '/'"$HN"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g")

if [ -z $mt ]; then
	echo "Nothing|Found|Try|Another|Search"
else
	echo "$mt"

fi
#TGIF_Network|0000|tgif.network|passw0rd|62031

