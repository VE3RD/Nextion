#!/bin/bash
############################################################
#  Activate  Profile                                       #
#  VE3RD                                      2019/11/18   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
#echo "Save to Profile"

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
		 sudo sed -i '/^\[/h;G;/Modem/s/\(RXOffset=\).*/\1'"$m1"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/Modem/s/\(TXOffset=\).*/\1'"$m2"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/Info/s/\(RXFrequency=\).*/\1'"$m3"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/Info/s/\(TXFrequency=\).*/\1'"$m4"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/General/s/\(Callsign=\).*/\1'"$m5"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/General/s/\(Id=\).*/\1'"$m6"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/DMR/s/\(Id=\).*/\1'"$m6"'/m;P;d' $tofile 
        mt="P$1-$m1|$m2|$m3|$m4|$m5|$m6"
       echo "$mt"
      printf "$mt"
 fi

sudo /usr/local/sbin/mmdvmhost.service restart > /dev/null
