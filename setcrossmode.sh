#!/bin/bash
############################################################
#  Set or Reset Cross Mode Toggles                         #
#  $1 7-11  Select Mode to change  $2 enable= 0 or 1       #
#  Also enable corresponding network                       #
#  KF6S                                        09-14-2019  #
############################################################
set -o errexit
set -o pipefail
# Check all six modes and set each one to either 0 or 1

if [ -z "$1" ]; then
        exit
        else
        if [ "$1" = 7 ]; then sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"$2"'' /etc/dmr2ysf
			 sudo sed -i '/\[DMR Network 3\]/!b;n;cEnabled='"$2"'' /etc/dmrgateway
             if [ "$2"  = 1 ]; then  
		 sudo sed  -i 's/62031/62033/g' /etc/mmdvmhost
		 sudo sed  -i 's/tgif.network/127.0.0.2/g' /etc/mmdvmhost
		 sudo sed  -i 's/passw0rd/none/g' /etc/mmdvmhost
	fi

             if [ "$2" = 0 ]; then 
		 sudo sed  -i 's/62033/62031/g' /etc/mmdvmhost
		 sudo sed  -i 's/127.0.0.2/tgif.network/g' /etc/mmdvmhost
		 sudo sed  -i 's/none/passw0rd/g' /etc/mmdvmhost
             fi
 		sudo /usr/local/sbin/dmr2ysf.service restart
 		sudo /usr/local/sbin/mmdvmhost.service restart
        fi

        if [ "$1" = 8 ]; then sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"$2"'' /etc/dmr2nxdn
             if [ "$2"  = 1 ]; then  
		 sudo sed  -i 's/62031/62035/g' /etc/mmdvmhost
		 sudo sed  -i 's/tgif.network/127.0.0.3/g' /etc/mmdvmhost
		 sudo sed  -i 's/passw0rd/none/g' /etc/mmdvmhost
	fi

             if [ "$2" = 0 ]; then 
		 sudo sed  -i 's/62035/62031/g' /etc/mmdvmhost
		 sudo sed  -i 's/127.0.0.3/tgif.network/g' /etc/mmdvmhost
		 sudo sed  -i 's/none/passw0rd/g' /etc/mmdvmhost
             fi
 	  sudo /usr/local/sbin/dmr2nsdn.service restart
 	  sudo /usr/local/sbin/mmdvmhost.service restart

        fi

        if [ "$1" = 9 ]; then sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"$2"'' /etc/ysf2dmr
 	  sudo /usr/local/sbin/ysf2dmr.service restart

        fi

        if [ "$1" = 10 ]; then sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"$2"'' /etc/ysf2nxdn
          sudo /usr/local/sbin/ysf2nxdn.service restart
	fi

        if [ "$1" = 11 ]; then sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"$2"'' /etc/ysf2p25
          sudo /usr/local/sbin/ysf2p25.service restart 
	fi

fi;
