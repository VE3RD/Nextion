#!/bin/bash
############################################################
#  Create Validation File                                  #
#  VE3RD                                      2019-12-01   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
declare m1 integer

	     	m1=$(sed -nr "/^\[General\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
#		echo "$m1"
#            	echo $(($m1 << 2))
            	echo $(($m1 << 2)) > /usr/local/etc/Nextion_Support/user.txt
sudo mount -o remount,ro /

