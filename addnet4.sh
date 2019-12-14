#!/bin/bash
############################################################
#  Add Network 4 to /etc/dmrgateway                        #
#                                                          #
#  UNDER CONSTRUCTION                                      #
#                                                          #
#  VE3RD                                     2019-12-10    #
############################################################
set -o errexit
set -o pipefail

sudo mount -o remount,rw /
if [[ $(grep -c "\[DMR Network 4\]" /etc/dmrgateway) -eq "0" ]]; then
	sed -i '$ a\[DMR Network 4]\
Enabled=1\
Name=TGIF_Network\
Address=tgif.network\
Port=62031\
Local=62036\
Password="passw0rd"\
TGRewrite4=2,1,2,1,99999\
TGRewrite0=2,4000001,2,1,999999\
Debug=0\
Location=0' /etc/dmrgateway
fi

#sudo mount -o remount,ro /
