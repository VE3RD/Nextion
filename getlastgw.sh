#!/bin/bash
#################################################
#  Get Last Heard Network from DMRGateway	#
#						#
#						#
#  VE3RD 			2020-11-29	#
#################################################
set -o errexit
set -o pipefail

Addr=$(sed -nr "/^\[DMR Network\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
        if [ $Addr = "127.0.0.1" ]; then
                GW="ON"
                #fn=$(ls /var/log/pi-star/DMRGateway* | tail -n1 )
                NetType=$(sudo tail -n1 /var/log/pi-star/DMRG* | cut -d " " -f 4)
                NetNum=$(sudo tail -n1 /var/log/pi-star/DMRG* | cut -d " " -f 6)
		if [ "$NetType" = "RFRX" ]; then
   			echo "GW RF Net: $NetNum"
		else
   			echo "GW RX Net: $NetNum"
		fi
        else
                GW="OFF"
                ms=$(sudo sed -n '/^[^#]*'"$Addr"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g" | cut -d'|' -f1)
                echo "$ms"
        fi


#f1=$(ls -tr /var/log/pi-star/DMRG*)
f1=$(ls  /var/log/pi-star/DMRGateway* | tail -n1)

#echo "$f1"
NetType=$(sudo tail -n1 "$f1" | cut -d " " -f 4)
#echo "$NetType"
NetNum=$(sudo tail -n1 "$f1" | cut -d " " -f 6)
#echo "$NetNum"

#echo "$NetType: $NetNum"


