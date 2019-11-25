#!/bin/bash
############################################################
#  Set DMR Master Server from the Search Master Page       #
#  Param 1 is the Address, Param 2 is the Port             #
#  VE3RD                                      2019/11/25   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
#echo "Set DMR Master Server"
#sudo mount -o remount,ro /
sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
if [ -z "$2" ]; then
        exit
fi
#       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/dmr2ysf
#       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/dmr2nxdn
#       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2dmr
#       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2nxdn
#       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2p25
 

  	sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
  	sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost
	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$1"'/m;P;d'  /etc/mmdvmhost
#     echo "31-DMRGateway"
sudo /usr/local/sbin/mmdvmhost.service restart > /dev/null
