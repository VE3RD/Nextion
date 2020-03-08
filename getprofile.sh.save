#!/bin/bash
############################################################
#  Get  Profile from profiles.txt                          #
#  Returns a multi string | Separated                      #
#                                                          #
#                                                          #
#  VE3RD                                     2019-11-17    #
############################################################
set -o errexit
set -o pipefail
dirn=/usr/local/etc/Nextion_Support/profiles.txt
declare -i pnum
sudo mount -o remount,rw /

if [ -z "$1" ]; then
        exit
        else
pnum=$(echo $1 | sed 's/^0*//')
#pnum="$1"
		m1=$(sed -nr "/^\[Profile $pnum\]/ { :l /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m2=$(sed -nr "/^\[Profile $pnum\]/ { :l /^TXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m3=$(sed -nr "/^\[Profile $pnum\]/ { :l /^RXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m4=$(sed -nr "/^\[Profile $pnum\]/ { :l /^TXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m5=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Callsign[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m6=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m7=$(sed -nr "/^\[Profile $pnum\]/ { :l /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m8=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m9=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Mode[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)

	mt=$(sudo sed -n '/^[^#]*'"$m8"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g")
	m8=$( echo "$mt" | cut -d'|' -f1)
	sudo sed -i '/^\[/h;G;/Profile $pnum/s/\(Address=\).*/\1'"$m8"'/m;P;d'  /etc/mmdvmhost
#fi

               	mt="$m1|$m2|$m3|$m4|$m5|$m6|$m7|$m8|$m9"
		echo "$mt"
fi;

