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
	echo " Syntax: copyrd.sh NX????K??? 1 or 2  ?"
	echo " 1 Copies EA7KDO Files,   2 Copies VE3RD Files"
	echo " Third parameter disables command feedback inhibit" 
   	exit
fi

if [ "$3" ]; then
	if [ "$2" == "1" ]; then
		echo "Loading EA7KDO Screen Package"
	fi
	if [ "$2" == "2" ]; then
		echo "Loading VE3RD Screen Package"
	fi

fi


#Start Duration Timer
start=$(date +%s.%N)


#Disable all command feedback
if [ ! "$3" ]; then
	exec 3>&2
	exec 2> /dev/null 
fi

model=$1
tft='.tft' gz='.gz'
#Put Pi-Star file system in RW mode
sudo mount -o remount,rw /
sleep 1s

#Stop the cron service
sudo systemctl stop cron.service  > /dev/null

#/home/pi-star/Nextion_Temp/


#Test for /home/pi-star/Nextion_Temp and remove it, if it exists

if [ -d /home/pi-star/Nextion_Temp ]; then
  	sudo rm -R /home/pi-star/Nextion_Temp
fi

  # Get Nextion Screen/Scripts and support files from github
  # Get EA7KDO File Set

mount -o remount,size=128M /tmp/

if [ "$2" = 1 ]; then
	  sudo git clone --depth 1 https://github.com/EA7KDO/Nextion.Images /home/pi-star/Nextion_Temp
fi
  # Get VE3RD File Set
if [ "$2" = 2 ]; then
  	  sudo git clone --depth 1 https://github.com/VE3RD/Nextion /home/pi-star/Nextion_Temp
fi

if [ ! -d /usr/local/etc/Nextion_Support ]; then
	sudo mkdir /usr/local/etc/Nextion_Support
fi

sudo chmod +x /home/pi-star/Nextion_Temp/*.sh
sudo rsync -avq /home/pi-star/Nextion_Temp/* /usr/local/etc/Nextion_Support/ --exclude=NX* --exclude=profiles.txt
if [ ! -f /usr/local/etc/Nextion_Support/profiles.txt ]; then
        if [ "$3" ]; then
                echo "Replacing Missing Profiles.txt"
        fi
        cp  /home/pi-star/Nextion_Temp/profiles.txt /usr/local/etc/Nextion_Support/

fi

if [ "$3" ]; then
    echo "Remove Existing $model$tft and copy in the new one"
fi

if [ -f /usr/local/etc/$model$tft ]; then
	rm /usr/local/etc/$model$tft
fi
cp /home/pi-star/Nextion_Temp/$model$tft /usr/local/etc/


 FILE=/usr/local/etc/$model$tft
 if [ ! -f "$FILE" ]; then
        # Copy failed
      echo "No TFT File Available to Flash - Try Again"
	exit
 fi

sudo systemctl start cron.service  > /dev/null

duration=$(echo "$(date +%s.%N) - $start" | bc)
execution_time=`printf "%.2f seconds" $duration`

if [ ! "$3" ]; then
 exec 2>&3
fi 

echo "Script Completed: $execution_time"




