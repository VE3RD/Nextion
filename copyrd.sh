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
if [ -z "$1" ]; then
        exit
fi

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
FILE=/tmp/Nextion.Images
if [ -d "$FILE" ]; then
    rm -R /tmp/Nextion.Images
fi

  # Get Nextion Scrren/Scripts and support files from github
  ##  sudo git clone https://github.com/EA7KDO/Nextion.Images /tmp/
  sudo git clone https://github.com/VE3rd/Nextion /tmp/Nextion.Images/
  sudo chmod +x /tmp/Nextion.Images/*.sh
  sudo cp /tmp/Nextion.Images/* /usr/local/etc/Nextion_Support/

#Check to make sure that NO TFT file exists at the destination
#Then copy in the new one
rm /usr/local/etc/$model$tft
cp /tmp/Nextion.Images/$model$tft /usr/local/etc/

FILE=/usr/local/etc/$model$tft
if [ -f "$FILE" ]; then
#        echo "Nextion tft file successfully copied!"
# Copy OK do not echo to screen
else
# Copy failed n
#echo "No TFT File Available to Flash - Try Again"
#fi

#if test $status -eq 0
#then

#else
        #Put Pi-Star file system in RW mode
        sudo mount -o remount,rw /
        #Check to make sure that NO TFT file exists at the destination
        rm /usr/local/etc/$model$tft
        cp /tmp/Nextion.Images/$model$tft /usr/local/etc/$model$tft;
        status=$?
        if test $status -eq 0
        then
 #               echo "Nextion tft file successfully copied, on second try!"
        else
                echo "Nextion tft file copy failed!"
        fi
fi

sudo systemctl start cron.service  > /dev/null
exec 2>&3 
