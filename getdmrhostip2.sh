#!/bin/bash
############################################################
#  Lookup DMR Master IP in /usr/local/etc/DMR_Hosts.txt    #
#  Return IP Address.                                      #
#                                                          #
#                                                          #
#  KF6S                                        05-20-2019  #
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

#sed -n '/^\s*[^#]\|^$/!'p filename
mt=$(sudo sed -n '/^[^#]*'"$HN"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g")
#mt=$(sudo sed -n '/'"$HN"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g")
#var="${u:10:4}"
#echo "${var}"
#sed 's/^[^#]*DMRGateway \=.*/server string = '"$variable"' SAMBA/g' /usr/local/etc/DMR_Hosts.txt/usr/local/etc/DMR_Hosts.txt

if [ -z $mt ]; then
	echo "Nothing|Found|Try|Another|Search"
else
	echo "$mt"

fi
