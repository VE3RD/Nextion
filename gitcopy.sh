#!/bin/bash
#########################################################
#  Nextion TFT Support for Nextion 2.4" 		#
#  Gets all Scripts and support files from github       #
#  and copies them into the Nextion_Support directory   "
#  and copies the NX??? tft file into /usr/local/etc    #
#  and returns a script duration time to the Screen 	#
#  as a script completion flag				#
#							#
#  KF6S/VE3RD                               2020=02-09  #
#########################################################
# Use screen model from command $1
if [ -z "$2" ]; then
	echo " Syntax: copyrd.sh NX????K??? 1 or 2"
	echo " 1 Copies EA7KDO Files,   2 Copies VE3RD Files"
   	exit
fi

start=$(date +%s.%N)


#Disable all command feedback
exec 3>&2
exec 2> /dev/null 

model=$1
tft='.tft' gz='.gz'
#Put Pi-Star file system in RW mode
sudo mount -o remount,rw /
sleep 1s

#Stop the cron service
sudo systemctl stop cron.service  > /dev/null

#Test for /tmp/Nextion.Images and remove it, if it exists


  # Get Nextion Screen/Scripts and support files from github
if [ "$2" = 1 ]; then
	if [ -d /usr/local/etc/Nextion_Support ]; then
  		sudo rm -R /usr/local/etc/Nextion_Support
	fi
	  sudo git clone https://github.com/EA7KDO/Nextion.Images /usr/local/etc/Nextion_Support
          sudo chmod +x /usr/local/etc/Nextion_Support/*.sh
fi
if [ "$2" = 2 ]; then
	if [ -d /usr/local/etc/Nextion_Support ]; then
  		sudo rm -R /usr/local/etc/Nextion_Support
	fi
	if [ -d /home/pi-star/Nextion ]; then
  		sudo rm -R /home/pi-star/Nextion
	fi

  	  sudo git clone https://github.com/VE3RD/Nextion /home/pi-star/Nextion
 	  sudo chmod +x /home/pi-star/Nextion/*.sh
   	  if [ ! -d /usr/local/etc/Nextion_Support ]; then
		sudo mkdir /usr/local/etc/Nextion_Support
	  fi

          sudo cp /home/pi-star/Nextion/* /usr/local/etc/Nextion_Support/
fi
#Check to make sure that NO TFT file exists at the destination
#Then copy in the new one

if [ -f /usr/local/etc/$model$tft ]; then
	rm /usr/local/etc/$model$tft
fi
	cp /home/pi-star/Nextion/$model$tft /usr/local/etc/

#FILE=/usr/local/etc/$model$tft
#if [ -f "$FILE" ]; then
#        echo "Nextion tft file successfully copied!"
# Copy OK do not echo to screen
#else
# Copy failed 
#	echo "No TFT File Available to Flash - Try Again"
#fi

sudo systemctl start cron.service  > /dev/null

duration=$(echo "$(date +%s.%N) - $start" | bc)
execution_time=`printf "%.2f seconds" $duration`

exec 2>&3 

echo "Script Completed: $execution_time"




