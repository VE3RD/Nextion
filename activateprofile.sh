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

declare -i pnum

echo "Processing Profile = $1" > /home/pi-star/ActivateProfile.txt
sudo mount -o remount,rw /

if [ -z "$1" ]; then
   exit
else
#pnum="$1"
pnum=$(echo $1 | sed 's/^0*//')

                m1=$(sed -nr "/^\[Profile $pnum\]/ { :l /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m2=$(sed -nr "/^\[Profile $pnum\]/ { :l /^TXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m3=$(sed -nr "/^\[Profile $pnum\]/ { :l /^RXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m4=$(sed -nr "/^\[Profile $pnum\]/ { :l /^TXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m5=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Callsign[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m6=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m7=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Mode[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m8=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m9=$(sed -nr "/^\[Profile $pnum\]/ { :l /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m10=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Port[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m11=$(sed -nr "/^\[Profile 0\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m12=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m13=$(sed -nr "/^\[Profile 0\]/ { :l /^ExtId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)

m8a="$m8"
mt=$(sudo sed -n '/^[^#]*'"$m8"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g")
m8=$( echo "$mt" | cut -d'|' -f3)

	
		 sudo sed -i '/^\[/h;G;/Modem/s/\(RXOffset=\).*/\1'"$m1"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/Modem/s/\(TXOffset=\).*/\1'"$m2"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/Info/s/\(RXFrequency=\).*/\1'"$m3"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/Info/s/\(TXFrequency=\).*/\1'"$m4"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/General/s/\(Callsign=\).*/\1'"$m5"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/General/s/\(Id=\).*/\1'"$m6"'/m;P;d' $tofile 
		 sudo sed -i '/^\[/h;G;/DMR/s/\(Id=\).*/\1'"$m6"'/m;P;d' $tofile
	
		echo "Processing Profile = $1,  Mode = $m7" >> /home/pi-star/ActivateProfile.txt

	if [ "$m7" = 'DMR' ]; then 

                         sudo sed -i '/^\[/h;G;/DMR]/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162035/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1"passw0rd"/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$m8"'/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(ModeHang=\).*/\110/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR]/s/\(^Id=\).*/\1'"$m13"'/m;P;d'  /etc/mmdvmhost

			echo "$m7  $m8"  >> /home/pi-star/ActivateProfile.txt
                         sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
 
	fi 
        if [ "$m7" = 'DMRGateway' ]; then

                         sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162035/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1"passw0rd"/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$m8"'/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(ModeHang=\).*/\110/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR]/s/\(^Id=\).*/\1'"$m13"'/m;P;d'  /etc/mmdvmhost

                        echo "$m7  $m8"  >> /home/pi-star/ActivateProfile.txt

        fi




	if [ "$m7" = 'DMR2YSF' ]; then
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m6"'/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1127.0.0.2/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Port=\).*/\162033/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Local=\).*/\162034/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1'"none"'/m;P;d' /etc/mmdvmhost

		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Id=\).*/\1'"$m13"'/m;P;d' /etc/dmr2ysf
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(StartupDstId=\).*/\1'"$m9"'/m;P;d' /etc/dmr2ysf
		 sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/dmr2ysf


		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Enabled=\).*/\11/m;P;d' /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Name=\).*/\1'"DMR2YSF_Cross-Over"'/m;P;d' /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Id=\).*/\1'"$m13"'/m;P;d' /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Address=\).*/\1'"127.0.0.1"'/m;P;d' /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Port=\).*/\162033/m;P;d' /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Local=\).*/\162034/m;P;d' /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Password=\).*/\1'"PASSWORD"'/m;P;d' /etc/dmrgateway


                sudo /usr/local/sbin/dmr2ysf.service restart  > /dev/null
	fi
	if [ "$m7" = 'DMR2NXDN' ]; then
		 sudo sed -i '/^\[/h;G;/System Fusion/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost

		 sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(EnableWiresX=\).*/\11/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(StartupDstId=\).*/\1'"$m9"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$m8"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$m10"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"$m12"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Id=\).*/\1'"$m13"'/m;P;d' /etc/ysf2dmr
                sudo sed -i '/\[DMR Network\]/!b;n;cEnabled='"1"'' /etc/ysf2dmr

		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1YSF2DMR/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m6"'/m;P;d' /etc/ysfgateway

                sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
                sudo /usr/local/sbin/ysf2dmr.service restart  > /dev/null
	fi
	if [ "$m7" = 'YSF2DMR' ]; then
		 sudo sed -i '/^\[/h;G;/System Fusion/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost

		 sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(EnableWiresX=\).*/\10/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(LocalPort=\).*/\142013/m;P;d' /etc/ysf2dmr

		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(StartupDstId=\).*/\1'"$m9"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$m8"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$m10"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162035/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"$m12"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Id=\).*/\1'"$m13"'/m;P;d' /etc/ysf2dmr
                sudo sed -i '/\[DMR Network\]/!b;n;cEnabled='"1"'' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/Info/s/\(RXFrequency=\).*/\1'"$m3"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/Info/s/\(TXFrequency=\).*/\1'"$m4"'/m;P;d' /etc/ysf2dmr

		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1YSF2DMR/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m6"'/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/Info/s/\(RXFrequency=\).*/\1'"$m3"'/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/Info/s/\(TXFrequency=\).*/\1'"$m4"'/m;P;d' /etc/ysfgateway

                sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
                sudo /usr/local/sbin/ysf2dmr.service restart  > /dev/null
	fi
	if [ "$m7" = 'YSF2NXDN' ]; then
		 sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2nxdn
		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(EnableWiresX=\).*/\11/m;P;d' /etc/ysf2nxdn
		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(StartupDstId=\).*/\1'"$m9"'/m;P;d' /etc/ysf2nxdn
		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(Address=\).*/\1'"$m8"'/m;P;d' /etc/ysf2nxdn
		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(Port=\).*/\1'"$m10"'/m;P;d' /etc/ysf2nxdn
		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(Password=\).*/\1'"$m10"'/m;P;d' /etc/ysf2nxdn

		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(^Id=\).*/\1'"$m6"'/m;P;d' /etc/ysf2nxdn
		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(^Enabled=\).*/\11/m;P;d' /etc/ysf2nxdn

		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1YSF2NXDN/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m6"'/m;P;d' /etc/ysfgateway

		 sudo sed -i '/^\[/h;G;/System Fusion/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost
echo "YSF2NXDN"
                sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
                sudo /usr/local/sbin/ysf2nxdn.service restart  > /dev/null
	fi

	if [ "$m7" = 'YSF2P25' ]; then
		 sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(EnableWiresX=\).*/\11/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(StartupDstId=\).*/\1'"$m9"'/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(Address=\).*/\1'"$m8"'/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(Port=\).*/\1'"$m10"'/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(^Id=\).*/\1'"$m6"'/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(Password=\).*/\1'"$m12"'/m;P;d' /etc/ysf2p25

		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1YSF2P25/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m6"'/m;P;d' /etc/ysfgateway

		 sudo sed -i '/^\[/h;G;/System Fusion/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost
		 sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost



                sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
                sudo /usr/local/sbin/ysf2p25.service restart  > /dev/null
    
	fi



	if [ "$m7" = 'TGIF' ]; then 

                         sudo sed -i '/^\[/h;G;/DMR]/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162035/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"passw0rd"'/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1tgif.network/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(ModeHang=\).*/\110/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR]/s/\(^Id=\).*/\1'"$m13"'/m;P;d'  /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/DMR]/s/\(Enable=\).*/\11/m;P;d'  /etc/mmdvmhost

			echo "$m7   TGIF"

	fi 
 
fi

#sudo /usr/local/sbin/mmdvmhost.service restart > /dev/null
echo "Profile $pnum - Loaded  - $m8a"
