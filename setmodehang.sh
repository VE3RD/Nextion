#!/bin/bash
############################################################
#  Set or Modem Hang                                       #
#  VE3RD                                      2019/10/28   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
#echo "Set ModeHang"

if [ -z "$1" ]; then
        exit
        else
        if [ "$1" = 21 ]; then 
             if [ "$2"  > 1 ]; then  
		 sudo sed -i '/^\[/h;G;/DMR/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost      
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost      
	     fi  
        fi
        if [ "$1" = 22 ]; then 
             if [ "$2"  > 1 ]; then  
		 sudo sed -i '/^\[/h;G;/NXDN/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost  
		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost  
	     fi  
        fi
        if [ "$1" = 23 ]; then 
             if [ "$2"  > 1 ]; then  
		 sudo sed -i '/^\[/h;G;/System Fusion/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost     
		 sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost     
	     fi  
        fi
        if [ "$1" = 24 ]; then 
             if [ "$2"  > 1 ]; then  
		 sudo sed -i '/^\[/h;G;/P25/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost      
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost      
	     fi  
        fi
        if [ "$1" = 25 ]; then 
             if [ "$2"  > 1 ]; then  
		 sudo sed -i '/^\[/h;G;/D-Star/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost     
		 sudo sed -i '/^\[/h;G;/D-Star Network/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost     
	     fi  
        fi
fi
sudo mount -o remount,ro /
