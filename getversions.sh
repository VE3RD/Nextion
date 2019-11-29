#!/bin/bash
############################################################
#  Get Cross Mode 			                   #
#  Build Binary Bit Pattern                                #
#                                                          #
#  Returns a string      		                   #
#                                                          #
#  VE3RD                                        2019-11-14 #
############################################################
set -o errexit
set -o pipefail

if [ -z $1 ]; then
exit
fi

if [ $1 = 1 ]; then 
m1=$(sudo cat /etc/pistar-release | grep "\Pi-Star_Build_Date") 
m2=$(sudo cat /etc/pistar-release | grep "\Version")
m3=$(sudo cat /etc/pistar-release | grep "\ircddbgateway")  
mt="$m1|$m2|$m3"
echo "$mt"
fi

if [ $1 = 4 ]; then
m4=$(sudo cat /etc/pistar-release | grep "\dstarrepeater")  
m5=$(sudo cat /etc/pistar-release | grep "\MMDVMHost")  
m6=$(sudo cat /etc/pistar-release | grep "\kernel")
m7=$(sudo cat /etc/pistar-release | grep "\Hardware")
mt="$m4|$m5|$m6|$m7"
echo "$mt"


fi




#[Pi-Star]
#Pi-Star_Build_Date = 27-Aug-2019
#Version = 4.1.0-RC6
#ircddbgateway = 20181222
#dstarrepeater = 20181222
#MMDVMHost = 20191122_Pi-Star-v4
#kernel = 4.19.75-v7+
#Hardware = RPi

