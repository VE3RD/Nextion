#!/bin/bash
############################################################
#  Set NXDN2DMR Cross Mode Parameters                      #
#							   #
#  Enable "$1" = 1 Turn on NXDN2DMR Mode		   #
#  Enable "$1" = 0 Clears NXDN2DMR Mode & Sets DMR Master  #
#							   #
#  VE3RD                                      2020-04-28   #
############################################################
set -o errexit
set -o pipefail
if [ -z "$5" ]; then
    exit
else

sudo /usr/local/sbin/mmdvmhost.service stop  > /dev/null

sudo mount -o remount,rw /
#1 enable
#2 port  - Not Used
#3 address   - not Used
#4  target
#5 id
echo "$1|$2|$3|$4|$5" > /home/pi-star/dmr2n.txt
sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
echo "All Modes Cleared"

#1 Enable
#4 Startup

# If Enabled
	if [ "$1" = 1 ]; then
        		sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/dmr2nxdn
        		sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/nxdngateway
        		sudo sed -i '/^\[/h;G;/DMR]/s/\(Enabled=\).*/\11/m;P;d' /etc/nxdngateway
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/nxdngateway
                 	sudo sed -i '/^\[/h;G;/DMR]/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
                 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162035/m;P;d'  /etc/mmdvmhost
                 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.3/m;P;d'  /etc/mmdvmhost
                 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"none"'/m;P;d'  /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1'"$4"'/m;P;d' /etc/nxdngateway
        		sudo sed -i '/^\[/h;G;/DMR]/s/\(^Id=\).*/\1'"$5"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Id=\).*/\1'"$5"'/m;P;d' /etc/dmr2nxdn
        		sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Enabled=\).*/\11/m;P;d' /etc/dmrgateway
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/NXDN Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
			sudo /usr/local/sbin/dmr2nxdn.service restart > /dev/null
			sudo /usr/local/sbin/nxdngateway.service restart > /dev/null

	fi
# If Disabled
	if [ "$1" = 0 ]; then
 	        	sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/dmr2nxdn
        		sudo sed -i '/^\[/h;G;/DMR]/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR]/s/\(^Id=\).*/\1'"$5"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1tgif.network/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1'"passw0rd"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/NXDN]/s/\(^Enable=\).*/\10/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/NXDN Network/s/\(^Enable=\).*/\10/m;P;d' /etc/mmdvmhost
			sudo /usr/local/sbin/dmr2nxdn.service stop > /dev/null
			sudo /usr/local/sbin/nxdngateway.service stop > /dev/null
  
	fi

fi;
sudo /usr/local/sbin/mmdvmhost.service start  > /dev/null

sudo mount -o remount,ro /



