#!/bin/bash
############################################################
#  Set  DMR Gateway Configuration                          #
#  VE3RD                                      2019/10/28   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
#echo "Enable Voice"
#"This function requires DMRGateway-1 by VE3RD"
sudo mount -o remount,rw /
if [ -z "$1" ]; then
        exit
fi

#sudo sed -i '/\[Voice\]/!b;n;cEnable='"$1"'' /etc/dmrgateway
# sudo sed -i '/^\[/h;G;/[Voice/s/\(Enable=\).*/\1'"$1"'/m;P;d'  /etc/dmrgateway
# sudo sed -i '/^\[/h;G;/Voice/s/\(Enable=\).*/\1'"$1"'/m;P;d'  /etc/dmrgateway
sudo sed -i '/^\[/h;G;/Voice/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/dmrgateway

sudo /usr/local/sbin/dmrgateway.service restart 
