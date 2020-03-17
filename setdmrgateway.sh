#!/bin/bash
############################################################
#  Set or DMR Gateway Configuration                        #
#  VE3RD                                      2019/11/14   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
#echo "Set DMRGateway"

if [ -z "$2" ]; then
        exit
fi
  	sudo sed -i '/\[DMR\]/!b;n;cEnable='"$2"'' /etc/mmdvmhost
  	sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"$2"'' /etc/mmdvmhost

	sudo sed -i '/^\[/h;G;/Network '"$1"'/s/\(Enabled=\).*/\11/m;P;d'  /etc/dmrgateway
	sudo sed -i '/^\[/h;G;/Network '"$1"'/s/\(Name=\).*/\1TGIF_Network/m;P;d'  /etc/dmrgateway
	sudo sed -i '/^\[/h;G;/Network '"$1"'/s/\(Address=\).*/\1158.69.203.89/m;P;d'  /etc/dmrgateway
	sudo sed -i '/^\[/h;G;/Network '"$1"'/s/\(Port=\).*/\162031/m;P;d'  /etc/dmrgateway
	sudo sed -i '/^\[/h;G;/Network '"$1"'/s/\(Password=\).*/\1"passw0rd"/m;P;d'  /etc/dmrgateway
	sudo sed -i '/^\[/h;G;/Network '"$1"'/s/\(Enabled=\).*/\1'"$2"'/m;P;d'  /etc/dmrgateway

sudo /usr/local/sbin/dmrgateway.service restart
#sudo /usr/local/sbin/mmdvmhost.service restart
sudo mount -o remount,ro /
