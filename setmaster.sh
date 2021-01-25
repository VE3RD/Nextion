#!/bin/bash
############################################################
#  Set  DMR Gateway Configuration                          #
#  VE3RD                                      2019/10/28   #
############################################################
set -o errexit
set -o pipefail

if [ -z "$1" ]; then
        exit
fi


fromfile="/usr/local/etc/Nextion_Support/profiles.txt"
sudo /usr/local/sbin/mmdvmhost.service stop  > /dev/null
sudo mount -o remount,rw /
#echo "Set DMR Master Server"
sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
sleep 1
       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/dmr2ysf
       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/dmr2nxdn
       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2dmr
       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2nxdn
       sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2p25

                m6=$(sed -nr "/^\[Profile 0\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m7=$(sed -nr "/^\[Profile 0\]/ { :l /^Mode[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m8=$(sed -nr "/^\[Profile 0\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m9=$(sed -nr "/^\[Profile 0\]/ { :l /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m10=$(sed -nr "/^\[Profile 0\]/ { :l /^Port[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m11=$(sed -nr "/^\[Profile 0\]/ { :l /^ExtId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
 
#echo "$m6|$m7|$m8|m$10|$m11"

if [ "$1" = 31 ]; then 
sudo mount -o remount,rw /
		 sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.1/m;P;d'  /etc/mmdvmhost 
#30231
# 	sudo rm /var/log/pi-star/DMR*
#            echo "31-DMRGateway"
fi        
if [ "$1" = 32 ]; then 
sudo mount -o remount,rw /
		 sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
 
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Enabled=\).*/\10/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Name=\).*/\1DMR2YSF_Cross-over/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Id=\).*/\1'"$m6"'/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Address=\).*/\1127.0.0.2/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Port=\).*/\162033/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Local=\).*/\162034/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Password=\).*/\1passw0rd/m;P;d'  /etc/dmrgateway

		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162033/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162034/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.2/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/System Fusion/s/\(Enable=\).*/\10/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(Enable=\).*/\10/m;P;d'  /etc/mmdvmhost
                  sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"1"'' /etc/dmr2ysf
#		echo "32-DMR2YSF"
fi
if [ "$1" = 33 ]; then 
sudo mount -o remount,rw /
		 sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost

		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Enabled=\).*/\10/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Name=\).*/\1DMR2NXDN_Cross-over/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Id=\).*/\1302073304/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Address=\).*/\1127.0.0.3/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Port=\).*/\162035/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Local=\).*/\162036/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Password=\).*/\1passw0rd/m;P;d'  /etc/dmrgateway

		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162035/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162036/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.3/m;P;d'  /etc/mmdvmhost

      		 sudo sed -i '/^\[/h;G;/NXDN/s/\(Enable=\).*/\10/m;P;d'  /etc/mmdvmhost
      		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(Enable=\).*/\10/m;P;d'  /etc/mmdvmhost
#		echo "33-DMR2NXDN"
fi
if [ "$1" = 34 ]; then 	

                        addr=$(sudo sed -n '/'"tgif"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f3 | head -1)
                        pwd=$(sudo sed -n '/'"tgif"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f4 | head -1)
                        port=$(sudo sed -n '/'"tgif"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f5 | head -1)

                        sudo mount -o remount,rw /
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$addr"'/m;P;d'  /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$port"'/m;P;d'  /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"$pwd"'/m;P;d'  /etc/mmdvmhost

                         sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162038/m;P;d'  /etc/mmdvmhost
			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(ModeHang=\).*/\110/m;P;d'  /etc/mmdvmhost
			 sudo sed -i '/^\[/h;G;/General/s/\(Id=\).*/\1'"$m6"'/m;P;d'  /etc/mmdvmhost
			 sudo sed -i '/^\[/h;G;/DMR/s/\(Id=\).*/\1'"$m11"'/m;P;d'  /etc/mmdvmhost
#			echo "34-TGIF_Network"
fi
if [ "$1" = 35 ]; then 
                        addr=$(sudo sed -n '/'"3021"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f3)
                        port=$(sudo sed -n '/'"3021"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f5)
			pwd=$(sudo grep Password  /etc/dstar-radio.mmdvmhost | cut -d'=' -f2)
			sudo mount -o remount,rw /

			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$port"'/m;P;d'  /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$addr"'/m;P;d'  /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"$pwd"'/m;P;d'  /etc/mmdvmhost

			 sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost

			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162035/m;P;d'  /etc/mmdvmhost
#			echo "35-BM Network 3021"  #3021
fi
if [ "$1" = 36 ]; then 
                        addr=$(sudo sed -n '/'"3101"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f3)
                        port=$(sudo sed -n '/'"3101"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f5)
			pwd=$(sudo grep Password  /etc/dstar-radio.mmdvmhost | cut -d'=' -f2)
			sudo mount -o remount,rw /

			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$port"'/m;P;d'  /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$addr"'/m;P;d'  /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"$pwd"'/m;P;d'  /etc/mmdvmhost

			 sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162035/m;P;d'  /etc/mmdvmhost
#			echo "36-BM Network 3101"  #3101 
fi
if [ "$1" = 37 ]; then 
                        addr=$(sudo sed -n '/'"3102"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f3)
                        port=$(sudo sed -n '/'"3102"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f5)
			pwd=$(sudo grep Password  /etc/dstar-radio.mmdvmhost | cut -d'=' -f2)
			sudo mount -o remount,rw /

			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$port"'/m;P;d'  /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$addr"'/m;P;d'  /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"$pwd"'/m;P;d'  /etc/mmdvmhost

			 sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162035/m;P;d'  /etc/mmdvmhost

#			echo "37-BM Network 3102"  #3102 
fi
if [ "$1" = 38 ]; then 
                        addr=$(sudo sed -n '/'"3103"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f3)
                        port=$(sudo sed -n '/'"3103"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f5)
			pwd=$(sudo grep Password  /etc/dstar-radio.mmdvmhost | cut -d'=' -f2)
			sudo mount -o remount,rw /

			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$port"'/m;P;d'  /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$addr"'/m;P;d'  /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"$pwd"'/m;P;d'  /etc/mmdvmhost

			 sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162035/m;P;d'  /etc/mmdvmhost

#			echo "$m1"
#			echo "38-BM Network 3103"  #3103 
fi
if [ "$1" = 39 ]; then
                        addr=$(sudo sed -n '/'"prime"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f3)
                        pwd=$(sudo sed -n '/'"prime"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f4)
                        port=$(sudo sed -n '/'"prime"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f5)
			sudo mount -o remount,rw /
			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$port"'/m;P;d'  /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$addr"'/m;P;d'  /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"$pwd"'/m;P;d'  /etc/mmdvmhost

			 sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost        		
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162036/m;P;d'  /etc/mmdvmhost
#                        echo "39-Prime Network"  
fi;
if [ "$1" = 40 ]; then
			addr=$(sudo sed -n '/'"mnet"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f3)
			pwd=$(sudo sed -n '/'"mnet"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f4)
			port=$(sudo sed -n '/'"mnet"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f5)

			sudo mount -o remount,rw /
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"$pwd"'/m;P;d'  /etc/mmdvmhost
			sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$addr"'/m;P;d'  /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$port"'/m;P;d'  /etc/mmdvmhost

			 sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
			 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost	                         
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162027/m;P;d'  /etc/mmdvmhost
#                        echo "40-MNet Network"  
fi;

sudo /usr/local/sbin/mmdvmhost.service restart 

if [ "$1" = 31 ]; then 
	sudo /usr/local/sbin/dmrgateway.service restart
fi
sudo mount -o remount,ro /
