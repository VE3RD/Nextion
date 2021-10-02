#!/bin/bash
############################################################
#  Get Master Server 			                   #
#                                                          #
#  Returns a string representing the Master Server         #
#                                                          #
#  VE3RD                                     2019-11-14    #
############################################################
set -o errexit
set -o pipefail


Addr=$(sed -nr "/^\[DMR Network\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
f1=$(ls  /var/log/pi-star/DMRGateway* | tail -n1)


        if [ $Addr = "127.0.0.1" ]; then
		echo "DMRGateway"
        else
                GW="OFF"
                ms=$(sudo sed -n '/^[^#]*'"$Addr"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g" | cut -d'|' -f1)
                echo "MS: $ms"
        fi


