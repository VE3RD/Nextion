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


#m1=$(sudo cat /etc/mmdvmhost | grep "\[DMR\]" -A 1 | grep "Enable=" | cut -b 8-9)
#if [ $m1 = "0" ]; then
#	echo "DMR OFF"
#	exit
#fi

Addr=$(sed -nr "/^\[DMR Network\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
	if [ $Addr = "127.0.0.1" ]; then
		GW="ON"
	else
		GW="OFF"
	fi
mtf=$(sudo sed -n '/^[^#]*'"$Addr"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g" | cut -d'|' -f1)


if [ "$mtf" = 'DMRGateway' ]; then
	f1=$(ls -tr /var/log/pi-star/DMRG*)
	tt=$(grep Name= $f1 | tail -n1)
	tt0=$(echo "$tt" | cut -d' ' -f4)

	if [ "$tt0" = "RF" ]; then
        	nt=$(echo "$tt" | cut -d' ' -f7 | cut -d'=' -f2)
#        	echo "$nt"
	fi
	if [ "$tt0" = "Network" ]; then
        	nt=$(echo "$tt" | cut -d' ' -f5)
#        	echo "$nt"
	fi

fi
echo "$GW:$mtf:$nt"

