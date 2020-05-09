#!/bin/bash
############################################################
#  Set YSF2DMR Parameters                                  #
#							   #
#  Enable "$1" = 1 Sets YSF2DMR Mode			   #
#  Enable "$1" = 0 Clears YSF2DMR Mode & Sets DMR Master   #
#							   #
#  VE3RD                                      2020-01-11   #
############################################################
set -o errexit
set -o pipefail

args=("$@")

# Parameter List
#1) 1-On 0-Off to TGIF
#2) WiresXCommandPassthrough / EnableWiresX (1)
#3) Port (62031)
#4) Address  (tgif.network) 
#5) Startup TG (31665)
#6) DMR ID  (xxxxxxx)
#7) Enable Unlink (0)

function default
{
p1=${args[0]}
p2=1
p3=62031
p4=tgif.network
p5=31665
p6=302073317
p7=0
}

function setinputs
{
p1=${args[0]}
p2=${args[1]}
p3=${args[2]}
p4=${args[3]}
p5=${args[4]}
p6=${args[5]}
p7=${args[6]}
}

if [ -z "$1" ]; then
	echo "You must mprovide at least one paramter"
	echo " Param 1 = 1 to Set YSF2DMR"
	echo " Param 1 = 0 to set TGIF"
exit

fi


if [ -z "$7" ]; then
	echo "Setting Defaults"
	default
else
	echo "Using provided inputs"
	setinputs
fi


sudo mount -o remount,rw /
sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
#echo "All Modes Cleared"
# If Enabled
sudo cp /etc/mmdvmhost /etc/mmdvmhost.tmp
	if [ "$p1" == 1 ]; then
			echo "Setting YSF Enable Parameters"

        		sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
        		sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
        		sudo sed -i '/^\[/h;G;/General/s/\(WiresXCommandPassthrough=\).*/\1'"$p2"'/m;P;d' /etc/ysfgateway
        		sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1YSF2DMR/m;P;d' /etc/ysfgateway

        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(EnableUnlink=\).*/\1'"$p7"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\1'"$p1"'/m;P;d' /etc/ysf2dmr
			echo "Setting YSF General Parameters"
        		sudo sed -i '/^\[/h;G;/YSF Network/s/\(EnableWiresX=\).*/\1'"$p2"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$p3"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162037/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$p4"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(StartupDstId=\).*/\1'"$p5"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Id=\).*/\1'"$p6"'/m;P;d' /etc/ysf2dmr
#        		sudo sed -i '/^\[/h;G;/YSF Network/s/\(DstPort=\).*/\13200/m;P;d' /etc/ysf2dmr
#        		sudo sed -i '/^\[/h;G;/YSF Network/s/\(LocalPort=\).*/\14200/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/YSF Network/s/\(DstPort=\).*/\142000/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/YSF Network/s/\(LocalPort=\).*/\142013/m;P;d' /etc/ysf2dmr

        		sudo sed -i '/^\[/h;G;/System Fusion]/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
        		sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
	fi
# If Disabled
	if [ "$p1" == 0 ]; then
			echo "Clearing YSF Parameters"
			## Clear YSF Parameters
 	        	sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/System Fusion/s/\(Enable=\).*/\10/m;P;d' /etc/mmdvmhost.tmp
        		sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enabled=\).*/\10/m;P;d' /etc/ysfgateway
        		sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enabled=\).*/\10/m;P;d' /etc/ysfgateway

			## Ser DMR Master
			echo "Setting TGIF Parameters"
        		sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp

        		sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$p6"'/m;P;d' /etc/mmdvmhost.tmp
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$p3"'/m;P;d' /etc/mmdvmhost.tmp
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$p4"'/m;P;d' /etc/mmdvmhost.tmp

  
	fi

sudo /usr/local/sbin/mmdvmhost.service stop 
sudo cp /etc/mmdvmhost.tmp /etc/mmdvmhost
sudo /usr/local/sbin/mmdvmhost.service restart
sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
sudo /usr/local/sbin/ysf2dmr.service restart  > /dev/null
 
sudo mount -o remount,ro /
echo "Done"

