#!/bin/bash
#################################################
#  Get User Info from User ID     		#
#						#
#						#
#  VE3RD 			2020-11-19	#
#################################################
set -o errexit
set -o pipefail

#if [ -z "$1" ]; then
#	exit
#fi
sudo mount -o remount,rw /
#sudo mount -o remount,ro /


LastUID=$(tail -n1 /var/log/pi-star/DMRGateway* | tail -n1 |  cut -d " " -f11)
grep "$LastUID" /usr/local/etc/stripped.csv



	
