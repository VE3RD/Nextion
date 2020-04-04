#!/bin/bash
############################################################
#  Set Cross Mode Targets                                  #
#  VE3RD                                      2019-11-28   #
############################################################
set -o errexit
set -o pipefail
# Check all five cross modes and set each one to either 0 or 1
#Clear all Main Modes
sudo mount -o remount,rw /
if [ -z "$2" ]; then
    exit
else

    if [ "$1" = 1 ]; then 
	#DMR2YSF
	sudo sed -i '/^\[/h;G;/DMR Network/s/\(DefaultDstTG=\).*/\1'"$2"'/m;P;d' /etc/dmr2ysf
    fi
 
    if [ "$1" = 2 ]; then 
	#DMR2NXDN
	sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1'"$2"'/m;P;d' /etc/dmrgateway
    fi
    if [ "$1" = 3 ]; then 
 	#YSF2DMR	
	sudo sed -i '/^\[/h;G;/DMR Network/s/\(StartupDstId=\).*/\1'"$2"'/m;P;d' /etc/ysf2dmr
    fi
 
    if [ "$1" = 4 ]; then 
	#YSF2NXDN
	sudo sed -i '/^\[/h;G;/NXDN Network/s/\(StartupDstId=\).*/\1'"$2"'/m;P;d' /etc/ysf2nxdn
    fi
 
    if [ "$1" = 5 ]; then
	#YSF2P25 
        sudo sed -i '/^\[/h;G;/P25 Network/s/\(StartupDstId=\).*/\1'"$2"'/m;P;d' /etc/ysf2p25
    fi

    if [ "$1" = 6 ]; then
	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Id=\).*/\1'"$2"'/m;P;d' /etc/ysf2dmr 
 	sudo sed -i '/\[DMR Network\]/!b;n;cId='"$2"'' /etc/ysf2dmr    
    fi

    if [ "$1" = 7 ]; then 
 	sudo sed -i '/\[NXDN Network\]/!b;n;cId='"$2"'' /etc/ysf2nxdn    
    fi
 
fi
#sudo /usr/local/sbin/mmdvmhost.service restart  > /dev/null
sudo mount -o remount,ro /
