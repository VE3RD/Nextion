#!/bin/bash
############################################################
#  Set Profile                                       #
#  VE3RD                                      2019/10/28   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
#echo "Save to Profile"

dirn=/usr/local/etc/Nextion_Support/profiles.txt
if [ -z "$3" ]; then
   exit
else
	mt=$( sudo sed -i '/^\[/h;G;/Profile '"$1"'/s/\('"$2"'=\).*/\1'"$3"'/m;P;d' $dirn)     
fi
