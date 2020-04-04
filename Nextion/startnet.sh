#!/bin/bash
############################################################
#  Clear Modes in /etc/mmdvmhost                           #
#  Also disable corresponding network                      #
#							   #
#  VE3RD                                        2019-12-04 #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

# Clear all six modes and set each one to either 0 
# Set DMR to 1

if [ -z "$1" ]; then
   	exit
   	else

	if [ "$1" = "TGIF" ]; then
  	echo " Starting TGIF"               
        	sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
	     	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
	     	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1tgif.network/m;P;d'  /etc/mmdvmhost
	     	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1passw0rd/m;P;d'  /etc/mmdvmhost
	fi

	if [ "$1" = "BM" ]; then
	   echo "Starting BM"
                sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
	     	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
                sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1158.69.203.89/m;P;d'  /etc/mmdvmhost  #3201
           #     sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1107.191.99.14/m;P;d'  /etc/mmdvmhost  #3101
 	fi 

	if [ "$1" = "DMR+" ]; then
	   echo "Starting DMR+"
                sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
		sudo sed -i '/^\[/h;G;/Network 2/s/\(Enabled=\).*/\11/m;P;d'  /etc/dmrgateway
	fi

	#if [ "$1" = "QRM" ]; then
	 # Future
	#else
	if [ "$1" = "FDARN" ]; then
	   echo "Starting FDARN"
               sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1primary.fdarn.com/m;P;d'  /etc/mmdvmhost
 	fi

fi;
