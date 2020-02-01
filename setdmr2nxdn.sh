#!/bin/bash
############################################################
#  Set YSF2DMR Parameters                                  #
#							   #
#  Enable "$1" = 1 Sets YSF2DMR Mode			   #
#  Enable "$1" = 0 Clears YSF2DMR Mode & Sets DMR Master   #
#							   #
#  VE3RD                                      2020-01-11   #
############################################################
set -o errexit
set -o pipefail
# Check all five cross modes and set each one to either 0 or 1
#Clear all Main Modes
sudo mount -o remount,rw /
#1 enable
#2 port  - Not Used
#3 address   - not Used
#4  target
#5 id
echo "$1|$2|$3|$4|$5" > /home/pi-star/dmr2n.txt
sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
#echo "All Modes Cleared"
if [ -z "$5" ]; then
    exit
else

#1 Enable
#4 Startup

# If Enabled
	if [ "$1" = 1 ]; then
        		sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/dmr2nxdn
        		sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/nxdngateway
        		sudo sed -i '/^\[/h;G;/DMR]/s/\(Enabled=\).*/\11/m;P;d' /etc/nxdngateway
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enabled=\).*/\11/m;P;d' /etc/nxdngateway
                 	sudo sed -i '/^\[/h;G;/DMR]/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
                 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162035/m;P;d'  /etc/mmdvmhost
                 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.3/m;P;d'  /etc/mmdvmhost
                 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"none"'/m;P;d'  /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1'"$4"'/m;P;d' /etc/nxdngateway
        		sudo sed -i '/^\[/h;G;/DMR]/s/\(^Id=\).*/\1'"$5"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Id=\).*/\1'"$5"'/m;P;d' /etc/dmr2nxdn
                        sudo /usr/local/sbin/dmr2ysf.service restart > /dev/null

	fi
# If Disabled
	if [ "$1" = 0 ]; then
 	        	sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/dmr2nxdn

        		sudo sed -i '/^\[/h;G;/DMR]/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR]/s/\(Id=\).*/\1'"$5"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1tgif.network/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1'"passw0rd"'/m;P;d' /etc/mmdvmhost
  
	fi

fi;
sudo /usr/local/sbin/mmdvmhost.service restart  > /dev/null
sudo mount -o remount,ro /



