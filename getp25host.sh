#!/bin/bash
############################################################
#  Lookup P25 Host /usr/local/etc/YSFHosts.txt 		   #
#  Return Multi Parameter String                           #
#                                                          #
#                                                          #
#  VE3RD                                      2020-01-11   #
############################################################
set -o errexit
set -o pipefail
# Use passed DMR Master name to lookup IP address
declare LEN number

if [ -z "$1" ]; then
exit
fi

typeset -u str="$1"

line1=$(sudo sed -n '/'"$str"'/p' /usr/local/etc/P25Hosts.txt | sed 's/,*\([^"]\)/\1/g;s/\([^"]\),*/\1/g' | sed -E "s/[[:space:]]+/|/g" | sed '1q;d')
line2=$(sudo sed -n '/'"$str"'/p' /usr/local/etc/P25Hosts.txt | sed -E "s/[[:space:]]+/|/g" | sed '2q;d')

ln1a=$( echo "$line1" | cut -d'|' -f2)
ln1b=$( echo "$line1" | cut -d'|' -f3)
ln1c=$( echo "$line1" | cut -d'|' -f4)

ln2b=$( echo "$line2" | cut -d'|' -f2)
ln2c=$( echo "$line2" | cut -d'|' -f3)
 
mt="$ln1a|$ln1b $ln1c|$ln2b|$ln2c"

if [ -z "$2" ]; then
        echo "$mt"

else
    case "$2" in
        "1")
                echo "$ln1a";;
        "2")
                echo "$ln1b $ln1c";;
        "3")
                echo "$ln2b";;
        "4")
                echo "$ln2c";;

     esac
fi


