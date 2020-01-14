#!/bin/bash
############################################################
#  Activate  Profile                                       #
#  VE3RD                                      2019/11/18   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
#echo "Save to Profile"
sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
fromfile="/usr/local/etc/Nextion_Support/profiles.txt"
tofile="/etc/mmdvmhost"

if [ -z "$1" ]; then
   exit
else
                m1=$(sed -nr "/^\[Profile $1\]/ { :l /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m2=$(sed -nr "/^\[Profile $1\]/ { :l /^TXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m3=$(sed -nr "/^\[Profile $1\]/ { :l /^RXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m4=$(sed -nr "/^\[Profile $1\]/ { :l /^TXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m5=$(sed -nr "/^\[Profile $1\]/ { :l /^Callsign[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m6=$(sed -nr "/^\[Profile $1\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m7=$(sed -nr "/^\[Profile $1\]/ { :l /^Mode[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m8=$(sed -nr "/^\[Profile $1\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m9=$(sed -nr "/^\[Profile $1\]/ { :l /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m10=$(sed -nr "/^\[Profile $1\]/ { :l /^Port[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
		 sudo sed -i '/^\[/h;G;/Modem/s/\(RXOffset=\).*/\1'"$m1"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/Modem/s/\(TXOffset=\).*/\1'"$m2"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/Info/s/\(RXFrequency=\).*/\1'"$m3"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/Info/s/\(TXFrequency=\).*/\1'"$m4"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/General/s/\(Callsign=\).*/\1'"$m5"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/General/s/\(Id=\).*/\1'"$m6"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/DMR/s/\(Id=\).*/\1'"$m6"'/m;P;d' $tofile
if [ "$m7" = 'YSF2DMR' ]; then
		 sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(EnableWiresX=\).*/\11/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1YSF2DMR/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/System Fusion/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR/s/\(^Enable=\).*/\10/m;P;d' /etc/mmdvmhost

		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(StartupDstId=\).*/\1'"$m9"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$m8"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$m10"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Id=\).*/\1'"$m6"'/m;P;d' /etc/ysf2dmr


                sudo sed -i '/\[DMR Network\]/!b;n;cEnabled='"1"'' /etc/ysf2dmr
                sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
                sudo /usr/local/sbin/ysf2dmr.service restart  > /dev/null
    
fi 
        mt="$m1|$m2|$m3|$m4|$m5|$m6"
       echo "$mt"
 fi

sudo /usr/local/sbin/mmdvmhost.service restart > /dev/null
