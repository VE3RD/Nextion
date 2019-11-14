#!/bin/bash
############################################################
#  Get Master Server 			                   #
#  $1 7-11 Select Mode to get status of                    #
#                                                          #
#  Returns a string		                           #
#                                                          #
#  KF6S                                        09-01-2019  #
############################################################
set -o errexit
set -o pipefail


m1=$(sudo cat /etc/mmdvmhost | grep "\[DMR\]" -A 1 | grep "Enable=" | cut -b 8-9)
if [ $m1 = "0" ]; then
echo "DMR OFF"
exit
fi
	Addr=$(sed -nr "/^\[DMR Network\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)

	if [ $Addr = tgif.network ]; then
		echo "TGIF_Network"
	elif [ $Addr = 127.0.0.1 ]; then
		echo "DMRGateway"
	elif [ $Addr = 127.0.0.2 ]; then
		echo "DMR2YSF"
	elif [ $Addr = 127.0.0.3 ]; then
		echo "DMR2NXDN"
	elif [ $Addr = 158.69.203.89 ]; then
		echo "BM 3021 Can"
	elif [ $Addr = 107.191.99.14 ]; then
		echo "BM 3101 US"
	elif [ $Addr = 74.91.114.19 ]; then
		echo "BM 3102 US"
	elif [ $Addr = primary.fdarn.com ]; then
		echo "FDARN_Network"
	fi;
