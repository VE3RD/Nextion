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

mt=$(sudo sed -n '/^[^#]*'"$HN"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g")

if [ -z $mt ]; then
	echo "Nothing|Found|Try|Another|Search"
else
	echo "$mt"

fi

