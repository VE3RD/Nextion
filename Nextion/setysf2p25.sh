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

echo "$1|$2|$3|$4|$5|$6|$7" > /home/pi-star/ysf2p25.txt

if [ -z "$7" ]; then
    echo "Insufficient Number of Parameters"
    exit
else
sudo /usr/local/sbin/mmdvmhost.service stop  > /dev/null
sudo mount -o remount,rw /
sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
# If Enabled
        if [ "$1" = 1 ]; then
                        sudo sed -i '/^\[/h;G;/System Fusion/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/mmdvmhost

                        sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/ysfgateway
                        sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/ysfgateway
                        sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1YSF2P25/m;P;d' /etc/ysfgateway
                        sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$7"'/m;P;d' /etc/ysfgateway

                        sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\1'"$1"'/m;P;d' /etc/ysf2p25
                        sudo sed -i '/^\[/h;G;/P25 Network/s/\(Enabled=\).*/\1'"$1"'/m;P;d' /etc/ysf2p25
                        sudo sed -i '/^\[/h;G;/P25 Network/s/\(EnableWiresX=\).*/\10/m;P;d' /etc/ysf2p25
                        sudo sed -i '/^\[/h;G;/P25 Network/s/\(StartupDstId=\).*/\1'"$5"'/m;P;d' /etc/ysf2p25
                        sudo sed -i '/^\[/h;G;/P25 Network/s/\(^Id=\).*/\1'"$7"'/m;P;d' /etc/ysf2p25

                        sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
                        sudo /usr/local/sbin/ysf2p25.service restart  > /dev/null
                        sudo /usr/local/sbin/p25gateway.service restart  > /dev/null

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

        fi



fi;
sudo /usr/local/sbin/mmdvmhost.service start  > /dev/null

sudo mount -o remount,ro /


