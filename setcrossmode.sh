#!/bin/bash
############################################################
#  Set or Reset Cross Mode Toggles                         #
#  $1 7-11  Select Mode to change  $2 enable= 0 or 1       #
#  Also enable corresponding network                       #
#  KF6S                                        09-14-2019  #
############################################################
set -o errexit
set -o pipefail
# Check all five cross modes and set each one to either 0 or 1
#Clear all Main Modes
sudo mount -o remount,rw /
echo "Modes Cleared & Set to DMR"
sudo /usr/local/etc/Nextion_Support/clearmodes.sh
if [ -z "$1" ]; then
        exit
        else
        if [ "$1" = 7 ]; then 
           #  sudo /usr/local/sbin/dmr2ysf.service stop
             if [ "$2"  = 1 ]; then  
 	     	 sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"1"'' /etc/dmr2ysf
  		 sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162033/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.2/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1none/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/Network 3/s/\(Enabled=\).*/\11/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/Network 3/s/\(Name=\).*/\1DMR2YSF_Cross-over/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/Network 3/s/\(Address=\).*/\1127.0.0.1/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/Network 3/s/\(Port=\).*/\162033/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/Network 3/s/\(Local=\).*/\162034/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/Network 3/s/\(Password=\).*/\1"PASSWORD"/m;P;d'  /etc/dmrgateway
    	 	 sudo /usr/local/sbin/dmr2ysf.service restart
		echo "Setting DMR2YSF Crossover Mode"
	     fi  
	     if [ "$2" = 0 ]; then 
	         sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/dmr2ysf
  		 sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1tgif.network/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1passw0rd/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/Network 3/s/\(Enabled=\).*/\10/m;P;d'  /etc/dmrgateway
		echo "Clearing DMR2YSF Crossover Mode"
             fi
        fi

        if [ "$1" = 8 ]; then 
 	    # sudo /usr/local/sbin/dmr2nxdn.service  stop
             if [ "$2"  = 1 ]; then  
 	         sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"1"'' /etc/dmr2nxdn 
                 sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                 sudo sed -i '/^\[/h;G;/Network 3/s/\(Enabled=\).*/\11/m;P;d'  /etc/dmrgateway
                 sudo sed -i '/^\[/h;G;/Network 3/s/\(Name=\).*/\1DMR2NXDN_Cross-over/m;P;d' /etc/dmrgateway
                 sudo sed -i '/^\[/h;G;/Network 3/s/\(Address=\).*/\1127.0.0.1/m;P;d'  /etc/dmrgateway
                 sudo sed -i '/^\[/h;G;/Network 3/s/\(Port=\).*/\162035/m;P;d'  /etc/dmrgateway
                 sudo sed -i '/^\[/h;G;/Network 3/s/\(Local=\).*/\162036/m;P;d'  /etc/dmrgateway
                 sudo sed -i '/^\[/h;G;/Network 3/s/\(Password=\).*/\1"PASSWORD"/m;P;d'  /etc/dmrgateway
	     	 sudo /usr/local/sbin/dmr2nxdn.service restart
		echo "Setting DMR2NXDN Crossover Mode"
	     fi             
             if [ "$2" = 0 ]; then 
	#	 sudo sed -i '/\[DMR Network 3\]/!b;n;cEnabled='"0"'' /etc/dmrgateway
 	         sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/dmr2nxdn 
                 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
                 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1tgif.network/m;P;d'  /etc/mmdvmhost
                 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1passw0rd/m;P;d'  /etc/mmdvmhost
		 echo "Clearing YSF2NXDN Crossover Mode"
             fi
# 	  sudo /usr/local/sbin/dmr2nxdn.service restart
 #	  sudo /usr/local/sbin/mmdvmhost.service restart

        fi

        if [ "$1" = 9 ]; then 
                if [ "$2" = 1 ]; then
 			sudo sed -i '/\[DMR\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
			sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"1"'' /etc/ysf2dmr
          		sudo sed -i '/\[System Fusion\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
          		sudo sed -i '/\[System Fusion Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
	                 sudo sed -i '/^\[/h;G;/Network 3/s/\(Enabled=\).*/\10/m;P;d'  /etc/dmrgateway
 	  		sudo /usr/local/sbin/ysf2dmr.service restart
			echo "Setting YSF2DMR Crossover Mode"
		fi
		if [ "$1" = 0 ]; then 
			sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                      	sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2dmr
                        sudo sed -i '/\[System Fusion\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
                        sudo sed -i '/\[System Fusion Network\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
	              	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
                 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1tgif.network/m;P;d'  /etc/mmdvmhost
                 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1passw0rd/m;P;d'  /etc/mmdvmhost
 	        echo "Clearing YSF2DMR Crossover Mode"
		fi 
        fi

        if [ "$1" = 10 ]; then 	
                if [ "$2" = 1 ]; then
	 		sudo sed -i '/\[DMR\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
			sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"1"'' /etc/ysf2nxdn
                	sudo sed -i '/\[System Fusion\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                	sudo sed -i '/\[System Fusion Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
			sudo /usr/local/sbin/ysf2nxdn.service restart
			echo "Setting YSF2NXDN Crossover Mode"
                fi
		if [ "$1" = 0 ]; then 
	 		sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                        sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2nxdn
                        sudo sed -i '/\[System Fusion\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
                        sudo sed -i '/\[System Fusion Network\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
	              	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
                 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1tgif.network/m;P;d'  /etc/mmdvmhost
                 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1passw0rd/m;P;d'  /etc/mmdvmhost
          		echo "Clearing YSF2NXDN Crossover Mode"
                fi
	fi

        if [ "$1" = 11 ]; then 
 		if [ "$2" = 1 ]; then 
			sudo sed -i '/\[DMR\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
			sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"1"'' /etc/ysf2p25
                	sudo sed -i '/\[System Fusion\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                	sudo sed -i '/\[System Fusion Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                        sudo /usr/local/sbin/ysf2p25.service restart
          		echo "Setting YSF2P25 Crossover Mode"
      fi

		if [ "$2" = 0 ]; then 
			sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                        sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2p25
                        sudo sed -i '/\[System Fusion\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
                        sudo sed -i '/\[System Fusion Network\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
	              	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
                 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1tgif.network/m;P;d'  /etc/mmdvmhost
                 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1passw0rd/m;P;d'  /etc/mmdvmhost
          		echo "Clearing YSF2P25 Crossover Mode"
                 fi

	fi
   sleep 2 

  sudo /usr/local/sbin/mmdvmhost.service restart

fi;
sleep 10
sudo mount -o remount,ro /
