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
	echo " "
	echo " Syntax: gitcopy.sh Param1 Param2 Param3"
	echo " Param1 = NX????K??? "
	echo " Param2 =  1 or 2 "
	echo " Param3 =  anything at all"
	echo "-----------------------------------------"
	echo " Param2=1 Copies EA7KDO Files"
	echo " Param2=2 Copies VE3RD Files"
	echo " Param3=? Disables command feedback inhibit.  Use Only from the Commansd Line" 
   	exit
fi

if [  "$2" != "1" ] && [ "$2" != "2" ]; then
	echo " "
	echo "Invalid  command syntax"
        echo " Syntax: gitcopy.sh NX????K??? 2  ?"
        echo " P2=1 Copies EA7KDO Files,   P2=2 Copies VE3RD Files"
        echo " P3=Anything - Disables command feedback inhibit Use Only from the Commansd Line"
       echo  "Param2 = $2"
        exit

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

#Test for /tmp/Nextion.Images and remove it, if it exists

if [ -d /tmp/Nextion.Images ]; then
  	sudo rm -R /tmp/Nextion.Images
fi

  # Get Nextion Screen/Scripts and support files from github
  # Get EA7KDO File Set

mount -o remount,size=128M /tmp/

if [ "$2" = 1 ]; then
	  sudo git clone --depth 1 https://github.com/EA7KDO/Nextion.Images /tmp/Nextion.Images
fi
  # Get VE3RD File Set
if [ "$2" = 2 ]; then
  	  sudo git clone --depth 1 https://github.com/VE3RD/Nextion /tmp/Nextion.Images
fi

if [ ! -d /usr/local/etc/Nextion_Support ]; then
	sudo mkdir /usr/local/etc/Nextion_Support
fi

sudo chmod +x /tmp/Nextion.Images/*.sh
sudo rsync -avq /tmp/Nextion.Images/* /usr/local/etc/Nextion_Support/ --exclude=NX* --exclude=profiles.txt
if [ ! -f /usr/local/etc/Nextion_Support/profiles.txt ]; then
        if [ "$3" ]; then
                echo "Replacing Missing Profiles.txt"
        fi
        cp  /tmp/Nextion.Images/profiles.txt /usr/local/etc/Nextion_Support/

fi

if [ "$3" ]; then
    echo "Remove Existing $model$tft and copy in the new one"
fi

if [ -f /usr/local/etc/$model$tft ]; then
	rm /usr/local/etc/$model$tft
fi
cp /tmp/Nextion.Images/$model$tft /usr/local/etc/


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




