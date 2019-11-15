#!/bin/bash
############################################################
#  Change Mode in /etc/mmdvmhost                           #
#  $1 1-6 Select Mode to change  $2 enable= 0 or 1         #
#  Also enable corresponding network                       #
#  KF6S                                        09-14-2019  #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

# Check all six modes and set each one to either 0 or 1

if [ -z "$1" ]; then
        exit
        else
        if [ "$1" = 1 ]; then 
               sudo sed -i '/^\[/h;G;/D-Star/s/\(Enable=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost
               sudo sed -i '/^\[/h;G;/D-Star Network/s/\(Enable=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost
        fi

        if [ "$1" = 2 ]; then 
               sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost
               sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost
        fi

        if [ "$1" = 3 ]; then 
               sudo sed -i '/^\[/h;G;/System Fusion/s/\(Enable=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost
               sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(Enable=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost
        fi

        if [ "$1" = 4 ]; then
               sudo sed -i '/^\[/h;G;/NXDN/s/\(Enable=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost
               sudo sed -i '/^\[/h;G;/NXDN Network/s/\(Enable=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost
        fi

        if [ "$1" = 5 ]; then 
                  sudo sed -i '/^\[/h;G;/P25/s/\(Enable=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost
               sudo sed -i '/^\[/h;G;/P25 Network/s/\(Enable=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost
     fi

        if [ "$1" = 6 ]; then 
               sudo sed -i '/^\[/h;G;/POCSAG/s/\(Enable=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost
               sudo sed -i '/^\[/h;G;/POCSAG Network/s/\(Enable=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost
        fi
fi;
sudo /usr/local/sbin/mmdvmhost.service restart > /dev/null
sudo mount -o remount,ro /

