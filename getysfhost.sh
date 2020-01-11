#!/bin/bash
############################################################
#  Lookup YSF Host /usr/local/etc/YSFHosts.txt 		   #
#  Return IP Address.                                      #
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
mt1=$(sudo sed -n '/'"$1"'/p' /usr/local/etc/YSFHosts.txt | sed -r 's/[;]+/|/g' | cut -d'|' -f1)
mt2=$(sudo sed -n '/'"$1"'/p' /usr/local/etc/YSFHosts.txt | sed -r 's/[;]+/|/g' | cut -d'|' -f2)
mt3=$(sudo sed -n '/'"$1"'/p' /usr/local/etc/YSFHosts.txt | sed -r 's/[;]+/|/g' | cut -d'|' -f3)
mt4=$(sudo sed -n '/'"$1"'/p' /usr/local/etc/YSFHosts.txt | sed -r 's/[;]+/|/g' | cut -d'|' -f5)
mt="$mt1|$mt2|$mt3|$mt4"
echo "$mt"


# the following line left active to show all available fields - Use | cut -d'|' -f4  to select field 4 separated by '|' as above
sudo sed -n '/'"$1"'/p' /usr/local/etc/YSFHosts.txt | sed -r 's/[;]+/|/g'
