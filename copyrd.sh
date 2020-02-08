#!/bin/bash
#########################################################
#  Nextion TFT Support for Nextion screen copy correct  #
#  file for user screen after Git Command.              #
#  KF6S                                     03-19-2019  #
#########################################################
# Use screen model from command $1
if [ -z "$1" ]; then
        exit
fi

model=$1
tft='.tft' gz='.gz'
#Put Pi-Star file system in RW mode
sudo mount -o remount,rw /
sleep 1s

 sudo systemctl stop cron.service  > /dev/null
 ##  sudo git clone https://github.com/EA7KDO/Nextion.Images /tmp/
  sudo git clone https://github.com/VE3rd/Nextion /tmp/Nextion.Images/
  sudo chmod +x /tmp/Nextion.Images/*.sh
  sudo cp /tmp/Nextion.Images/* /usr/local/etc/Nextion_Support/

#Check to make sure that NO TFT file exists at the destination
rm /usr/local/etc/$model$tft
cp /tmp/Nextion.Images/$model$tft /usr/local/etc/$model$tft;
status=$?

if test $status -eq 0
then
        echo "Nextion tft file successfully copied!"

else
        #Put Pi-Star file system in RW mode
        sudo mount -o remount,rw /
        #Check to make sure that NO TFT file exists at the destination
        rm /usr/local/etc/$model$tft
        cp /tmp/Nextion.Images/$model$tft /usr/local/etc/$model$tft;
        status=$?
        if test $status -eq 0
        then
                echo "Nextion tft file successfully copied, on second try!"
        else
                echo "Nextion tft file copy failed!"
        fi
fi
