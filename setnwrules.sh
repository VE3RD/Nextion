#!/bin/bash
############################################################
#  Set  Gateway Network ReWrite Rules in /etc/dmrgateway   #
#                                                          #
#                                                          #
#  VE3RD                                     2019-11-20    #
############################################################
set -o errexit
set -o pipefail

sudo mount -o remount,rw /

if [ -z "$3" ]; then
        exit
	else

# 	m1=$(echo "$3"  | sed -E "s/\./,/g") 

#           mt=$( sudo sed -i '/^\[/h;G;/DMR Network '"$1"'/s/\('"$2"'.=\).*/\1'"$3"'/m;P;d' /etc/dmrgateway)
#           mt=$( sudo sed -i '/^\[/h;G;/DMR Network '"$1"'/s/\('"$2"'=\).*/\1'"$3"'/m;P;d' /etc/dmrgateway)
           sudo sed -i '/^\[/h;G;/DMR Network '"$1"'/s/\('"$2"'.=\).*/\1'"$3"'/m;P;d' /etc/dmrgateway
           sudo sed -i '/^\[/h;G;/DMR Network '"$1"'/s/\('"$2"'=\).*/\1'"$3"'/m;P;d' /etc/dmrgateway

fi;
sudo mount -o remount,ro /
