#!/bin/bash
############################################################
#  Set VE3RD Nextion Screen Install                        #
#  VE3RD                                      2019/11/25   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
echo "Drive set to RW"

ddrive1=/usr/local/etc/
if [ !  /usr/local/etc/Nextion_Support/ ];  then
mkdir /usr/local/etc/Nextion_Support/
fi
ddrive2=/usr/local/etc/Nextion_Support/
sudo cp NX*.tft $ddrive1 
echo "   tft file coppied to $ddrive1"
sudo cp *.sh $ddrive2		
sudo cp *.txt $ddrive2		
echo "   Script files copied to $ddrive2"

