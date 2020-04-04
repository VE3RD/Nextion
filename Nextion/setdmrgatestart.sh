#!/bin/bash
############################################################
#  Set or DMR Gateway Start Params                         #
#  VE3RD                                      2020/01/01   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
#echo "Set DMRGateway"

if [ -z "$2" ]; then
        exit
fi

	if [ "$1" == 15 ]; then
   		sudo sed -i '/^\[/h;G;/Log/s/\(Display Level\).*/\1'"$2"'/m;P;d'  /etc/dmrgateway
	fi

	if [ "$1" == 16 ]; then
   		sudo sed -i '/^\[/h;G;/Log/s/\(File Level=\).*/\1'"$2"'/m;P;d'  /etc/dmrgateway
	fi

	if [ "$1" == 17 ]; then
		mt1=$(echo "$2" | cut -d'|' -f1)
		mt2=$(echo "$2" | cut -d'|' -f2)
		mt3=$(echo "$2" | cut -d'|' -f3)
		mt4=$(echo "$2" | cut -d'|' -f4)
   		sudo sed -i '/^\[/h;G;/General/s/\(StartNet=\).*/\1'"$mt1"'/m;P;d'  /etc/dmrgateway
   		sudo sed -i '/^\[/h;G;/General/s/\(Daemon=\).*/\1'"$mt2"'/m;P;d'  /etc/dmrgateway
   		sudo sed -i '/^\[/h;G;/General/s/\(RuleTrace=\).*/\1'"$mt3"'/m;P;d'  /etc/dmrgateway
   		sudo sed -i '/^\[/h;G;/General/s/\(Debug=\).*/\1'"$mt4"'/m;P;d'  /etc/dmrgateway

	fi


sudo /usr/local/sbin/dmrgateway.service restart
sudo /usr/local/sbin/mmdvmhost.service restart
sudo mount -o remount,ro /
