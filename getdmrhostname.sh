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

###################### New Script
Addr=$(sed -nr "/^\[DMR Network\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
f1=$(ls  /var/log/pi-star/DMRGateway* | tail -n1)


        if [ $Addr = "127.0.0.1" ]; then
                #fn=$(ls /var/log/pi-star/DMRGateway* | tail -n1 )
                NetType=$(sudo tail -n1 "$f1" | cut -d " " -f 4)
      #          NetNum=$(sudo tail -n1 /var/log/pi-star/DMRG* | cut -d " " -f 6)
                NetNum=$(sudo tail -n1 "$f1" | cut -d " " -f 6)
                NName=$(sed -nr "/^\[DMR Network "${NetNum##*( )}"\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
                 echo "GW Net ""${NetNum##*( )}"" $NName"

        else
                ms=$(sudo sed -n '/^[^#]*'"$Addr"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g" | cut -d'|' -f1)
                echo "MS: $ms"
        fi


