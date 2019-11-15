#!/bin/bash
############################################################
#  Set  DMR Gateway Configuration                          #
#  VE3RD                                      2019/10/28   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
#echo "Set DMR Master Server"
#sudo mount -o remount,ro /
sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
if [ -z "$1" ]; then
        exit
fi
       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/dmr2ysf
       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/dmr2nxdn
       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2dmr
       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2nxdn
       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2p25
 
if [ "$1" = 31 ]; then 
  		 sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
  		 sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.1/m;P;d'  /etc/mmdvmhost #30231
#            echo "31-DMRGateway"
        
elif [ "$1" = 32 ]; then 
  		 sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
  		 sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.2/m;P;d'  /etc/mmdvmhost
                  sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"1"'' /etc/dmr2ysf
#		echo "32-DMR2YSF"

elif [ "$1" = 33 ]; then 
 			sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
	  		 sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
		 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.3/m;P;d'  /etc/mmdvmhost
                      sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/dmr2nxdn
#			echo "33-DMR2NXDN"
elif [ "$1" = 34 ]; then 	
                        sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                         sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
           		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1tgif.network/m;P;d'  /etc/mmdvmhost
#			echo "34-TGIF_Network"
elif [ "$1" = 35 ]; then 
			echo "35-BM Network 3021"  #3101 
                        sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                         sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
           		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1158.69.203.89/m;P;d'  /etc/mmdvmhost
elif [ "$1" = 36 ]; then 
			echo "36-BM Network 3101"  #3101 
                        sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                         sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
           		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1107.191.99.14/m;P;d'  /etc/mmdvmhost
elif [ "$1" = 37 ]; then 
#			echo "37-BM Network 3102"  #3101 
                        sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                         sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
           		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\174.91.114.19/m;P;d'  /etc/mmdvmhost
elif [ "$1" = 38 ]; then
                        echo "38-FDARN Network"  
                        sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                         sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1primary.fdarn.com/m;P;d'  /etc/mmdvmhost
fi
sudo /usr/local/sbin/mmdvmhost.service restart >null
