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
typeset -u str="$1"

mtf=$(sudo sed -n '/^[^#]*'"$str"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g" | head -1)
mt1=$(echo "$mtf" | cut -d'|' -f1)
mt2=$(echo "$mtf" | cut -d'|' -f2)
mt3=$(echo "$mtf" | cut -d'|' -f3)
mt4=$(echo "$mtf" | cut -d'|' -f4)
mt5=$(echo "$mtf" | cut -d'|' -f5)

mt="$mt1|$mt2|$mt3|$mt4|$mt5"

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





