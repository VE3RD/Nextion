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
exit
fi

mtf=$(sudo sed -n '/^[^#]*'"$1"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g")
mt1=$(echo "$mtf" | cut -d'|' -f1)
mt2=$(echo "$mtf" | cut -d'|' -f2)
mt3=$(echo "$mtf" | cut -d'|' -f3)
mt4=$(echo "$mtf" | cut -d'|' -f4)
mt5=$(echo "$mtf" | cut -d'|' -f5)

echo "$mt1|$mt2|$mt3|$mt4|$mt5"

