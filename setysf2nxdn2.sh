#!/bin/bash
############################################################
#  Set YSF2NXDN Parameters                                 #
#							   #
#  Enable "$1" = 1 Sets YSF2NXDN Mode			   #
#  Enable "$1" = 0 Clears YSF2NXDN Mode & Sets DMR Master  #
#							   #
#  VE3RD                                      2020-01-11   #
############################################################
set -o errexit
set -o pipefail
# Check all five cross modes and set each one to either 0 or 1
#Clear all Main Modes
sudo mount -o remount,rw /
sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
if [ -z "$6" ]; then
    exit
else

                        sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\1'"$1"'/m;P;d' /etc/ysf2nxdn
#                        sudo sed -i '/^\[/h;G;/NXDN Network/s/\(Enabled=\).*/\1'"$1"'/m;P;d' /etc/ysf2nxdn
                        sudo sed -i '/^\[/h;G;/YSF Network/s/\(EnableWiresX=\).*/\1'"$2"'/m;P;d' /etc/ysf2nxdn
                        sudo sed -i '/^\[/h;G;/NXDN Network/s/\(StartupDstId=\).*/\1'"$5"'/m;P;d' /etc/ysf2nxdn
                        sudo sed -i '/^\[/h;G;/NXDN Network/s/\(^Id=\).*/\1'"$7"'/m;P;d' /etc/ysf2nxdn
                        sudo sed -i '/^\[/h;G;/System Fusion/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/ysfgateway
                        sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/mmdvmhost
			 sudo sed -i '/^\[/h;G;/YSF Network/s/\(Startup=\).*/\1'"$6"'/m;P;d' /etc/ysfgateway

                        sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/ysfgateway

# If Enabled
        if [ "$1" = 1 ]; then
                        sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\10/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\10/m;P;d' /etc/mmdvmhost
                        sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
                        sudo /usr/local/sbin/ysf2nxdn.service restart  > /dev/null
                        sudo /usr/local/sbin/nxdngateway.service restart  > /dev/null
        fi
        if [ "$1" = 0 ]; then
                        sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2nxdn
                        sudo sed -i '/^\[/h;G;/System Fusion/s/\(Enable=\).*/\10/m;P;d' /etc/mmdvmhost
                        ## Ser DMR Master
                        sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$3"'/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR/s/\(Id=\).*/\1'"$6"'/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$4"'/m;P;d' /etc/mmdvmhost
                        sudo /usr/local/sbin/ysfgateway.service stop > /dev/null
                        sudo /usr/local/sbin/ysf2nxdn.service stop  > /dev/null
                        sudo /usr/local/sbin/nxdngateway.service restart  > /dev/null

        fi



fi;
sudo /usr/local/sbin/mmdvmhost.service restart  > /dev/null
sudo mount -o remount,ro /





