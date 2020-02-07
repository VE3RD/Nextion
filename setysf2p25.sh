#!/bin/bash
############################################################
#  Set YSF2P25 Parameters                                  #
#							   #
#  Enable "$1" = 1 Sets YSF2P25 Mode			   #
#  Enable "$1" = 0 Clears YSF2P25 Mode & Sets DMR Master   #
#							   #
#  VE3RD                                      2020-01-27   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
sudo /usr/local/etc/Nextion_Support/clearallmodes.sh

echo "$1|$2|$3|$4|$5|$6" > /home/pi-star/ysf2p25.txt

if [ -z "$6" ]; then
    echo "Insufficient Number of Parameters"
    exit
else
sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
                        sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\1'"$1"'/m;P;d' /etc/ysf2p25
                        sudo sed -i '/^\[/h;G;/P25 Network/s/\(Enabled=\).*/\1'"$1"'/m;P;d' /etc/ysf2p25
                        sudo sed -i '/^\[/h;G;/P25 Network/s/\(EnableWiresX=\).*/\10/m;P;d' /etc/ysf2p25
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$3"'/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$4"'/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/NXDN Network/s/\(StartupDstId=\).*/\1'"$5"'/m;P;d' /etc/ysf2p25
                        sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$6"'/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/System Fusion/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/mmdvmhost

                        sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/ysfgateway

# If Enabled
        if [ "$1" = 1 ]; then
                        sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1YSF2P25/m;P;d' /etc/ysfgateway
                        sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\10/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\10/m;P;d' /etc/mmdvmhost
                        sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
                        sudo /usr/local/sbin/ysf2p25.service restart  > /dev/null
        fi
        if [ "$1" = 0 ]; then
                        sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2p25
                        sudo sed -i '/^\[/h;G;/System Fusion/s/\(Enable=\).*/\10/m;P;d' /etc/mmdvmhost
                        ## Ser DMR Master
                        sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$3"'/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR/s/\(Id=\).*/\1'"$6"'/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$4"'/m;P;d' /etc/mmdvmhost
                        sudo /usr/local/sbin/ysfgateway.service stop > /dev/null
                        sudo /usr/local/sbin/ysf2p25.service stop  > /dev/null

        fi



fi;
sudo /usr/local/sbin/mmdvmhost.service restart  > /dev/null

sudo mount -o remount,ro /


