#!/bin/bash
############################################################
#  Set or DMR Gateway Configuration                        #
#  VE3RD                                      2019/10/28   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
#echo "Set DMRGateway"

if [ -z "$1" ]; then
        exit
        else
        if [ "$1" = 21 ]; then 
             if [ "$2"  = 1 ]; then  
  		 sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
  		 sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
#		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
#		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.1/m;P;d'  /etc/mmdvmhost #30231
#		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1passw0rd/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/Network 1/s/\(Enabled=\).*/\11/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/Network 1/s/\(Name=\).*/\1TGIF_Network/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/Network 1/s/\(Address=\).*/\1158.69.203.89/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/Network 1/s/\(Port=\).*/\162031/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/Network 1/s/\(Password=\).*/\1"passw0rd"/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/Network 1/s/\(Enabled=\).*/\11/m;P;d'  /etc/dmrgateway
            echo "211 NET1 ON"
 
	     fi  
	     if [ "$2" = 0 ]; then 
		 sudo sed -i '/^\[/h;G;/Network 1/s/\(Enabled=\).*/\10/m;P;d'  /etc/dmrgateway
            echo "210 NET1 OFF"
             fi
        fi

        if [ "$1" = 22 ]; then 
             if [ "$2"  = 1 ]; then  
  		 sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
  		 sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.1/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\"PASSWORD"/m;P;d'  /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/Network 2/s/\(Name=\).*/\1DMR+_IPSC2-CAN-TRBO/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/Network 2/s/\(Address=\).*/\1207.35.36.178/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/Network 2/s/\(Port=\).*/\155555/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/Network 2/s/\(Password=\).*/\1"PASSWORD"/m;P;d'  /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/Network 2/s/\(Enabled=\).*/\11/m;P;d'  /etc/dmrgateway
		echo "221 NET2 ON"

	     fi             
             if [ "$2" = 0 ]; then 
		 sudo sed -i '/^\[/h;G;/Network 2/s/\(Enabled=\).*/\10/m;P;d'  /etc/dmrgateway
		 echo "220 NET2 OFF"
             fi
        fi

        if [ "$1" = 23 ]; then 
                if [ "$2" = 1 ]; then
 			sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
	  		 sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
		 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.1/m;P;d'  /etc/mmdvmhost
		 	sudo sed -i '/^\[/h;G;/Network 3/s/\(Enabled=\).*/\11/m;P;d'  /etc/dmrgateway
		 	sudo sed -i '/^\[/h;G;/Network 3/s/\(Name=\).*/\1DMR2YSF_Cross-over/m;P;d'  /etc/dmrgateway
		 	sudo sed -i '/^\[/h;G;/Network 3/s/\(Address=\).*/\1127.0.0.1/m;P;d'  /etc/dmrgateway
		 	sudo sed -i '/^\[/h;G;/Network 3/s/\(Port=\).*/\162033/m;P;d'  /etc/dmrgateway
		 	sudo sed -i '/^\[/h;G;/Network 3/s/\(Password=\).*/\1"PASSWORD"/m;P;d'  /etc/dmrgateway
			echo "231 NET3 ON"
		fi
		if [ "$2" = 0 ]; then 
		 	sudo sed -i '/^\[/h;G;/Network 3/s/\(Enabled=\).*/\10/m;P;d'  /etc/dmrgateway
 	        echo "230 NET3 OFF"
		fi 
        fi

        if [ "$1" = 24 ]; then 	
                if [ "$2" = 1 ]; then
                        sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                         sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
           		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.1/m;P;d'  /etc/mmdvmhost
             		sudo sed -i '/^\[/h;G;/Network 4/s/\(Enabled=\).*/\11/m;P;d'  /etc/dmrgateway
                        sudo sed -i '/^\[/h;G;/Network 4/s/\(Name=\).*/\1TGIF_Network/m;P;d'  /etc/dmrgateway
                        sudo sed -i '/^\[/h;G;/Network 4/s/\(Address=\).*/\1tgif.network/m;P;d'  /etc/dmrgateway
                        sudo sed -i '/^\[/h;G;/Network 4/s/\(Port=\).*/\162031/m;P;d'  /etc/dmrgateway
                        sudo sed -i '/^\[/h;G;/Network 4/s/\(Password=\).*/\1"passw0rd"/m;P;d'  /etc/dmrgateway
			echo "241 NET4 ON"
  
                fi
		if [ "$2" = 0 ]; then 
                        sudo sed -i '/^\[/h;G;/Network 4/s/\(Enabled=\).*/\10/m;P;d'  /etc/dmrgateway
          		echo "240 NET4 OFF"
                fi
	fi

        if [ "$1" = 25 ]; then 
 		if [ "$2" = 1 ]; then 
                  sudo sed -i '/^\[/h;G;/Network 5/s/\(Enabled=\).*/\11/m;P;d'  /etc/dmrgateway
		   echo "251   Network 5 Not yet Implemented"
      		fi

		if [ "$2" = 0 ]; then 
                  sudo sed -i '/^\[/h;G;/Network 5/s/\(Enabled=\).*/\10/m;P;d'  /etc/dmrgateway
          		echo "250   Network 5 Not yet Implemented"
                 fi

	fi

fi;
mmdvmhost.service restart
sudo mount -o remount,ro /
