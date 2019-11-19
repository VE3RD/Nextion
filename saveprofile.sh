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
if [ -z "$1" ]; then
   exit
else
    if [ -z "$2" ]; then
          exit
	else
		 sudo sed -i '/^\[/h;G;/Profile '"$1"'/s/\('"$2"'=\).*/\1'"$3"'/m;P;d' $dirn     
    fi
fi
