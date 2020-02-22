#!/bin/bash
############################################################
#  Get Profile Data From Pi-star                           #
#  Returns a multi string | Separated                      #
#                                                          #
#                                                          #
#  VE3RD                                     2019-11-17    #
############################################################
set -o errexit
set -o pipefail
#dirn=/usr/local/etc/Nextion_Support/profiles.txt
dirn=/etc/mmdvmhost

		ysfnet=$(sed -nr "/^\[System Fusion Network\]/ { :l /^Enable[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		ysf2dmr=$(sed -nr "/^\[System Fusion\]/ { :l /^Enable[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		ysf2nxdn=$(sed -nr "/^\[NXDN\]/ { :l /^Enable[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		ysf2p25=$(sed -nr "/^\[P25\]/ { :l /^Enable[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)

		m1=$(sed -nr "/^\[Modem\]/ { :l /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m2=$(sed -nr "/^\[Modem\]/ { :l /^TXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m3=$(sed -nr "/^\[Info\]/ { :l /^RXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m4=$(sed -nr "/^\[Info\]/ { :l /^TXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m5=$(sed -nr "/^\[General\]/ { :l /^Callsign[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m6=$(sed -nr "/^\[General\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)

		m7=$(sed -nr "/^\[Network\]/ { :l /^Mode[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/ysfgateway)

		m8=$(sed -nr "/^\[DMR Network\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m9=$(sed -nr "/^\[DMR Network\]/ { :l /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/ysf2dmr)

mt=$(sudo sed -n '/^[^#]*'"$m8"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g")
m8=$( echo "$mt" | cut -d'|' -f1)


if [ ysfnet == 1 ]; then
 	if [ ysf2dmr == 1 ]; then 
		m7="YSF2DMR" 
	fi
 	if [ ysf2nxdn == 1 ]; then 
		m7="YSF2NXDN" 
	fi
 	if [ ysf2p25 == 1 ]; then 
		m7="YSF2P25" 
	fi

fi
case $m8 in
	"tgif.network")
    	m7="TGIF"
    ;;

  	"127.0.0.1")
    	m7-"DMRGATEWAY"
    ;;
   
        "127.0.0.2")
        m7="DMR2YSF"

    ;;
        "127.0.0.3")
        m7-"DMR2NXDN"
    ;;
esac

               	mt="$m1|$m2|$m3|$m4|$m5|$m6|$m9|$m8|$m7"
		echo "$mt"

