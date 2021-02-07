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


m1=$(sudo sed -n '/^[^#]*Pi-Star_Build_Date/p' /etc/pistar-release | sed -E "s/[[:space:]]+//g")
m2=$(sudo sed -n '/^[^#]*Version/p' /etc/pistar-release | sed -E "s/[[:space:]]+//g")
m3=$(sudo sed -n '/^[^#]*ircddbgateway/p' /etc/pistar-release | sed -E "s/[[:space:]]+//g")
m4=$(sudo sed -n '/^[^#]*dstarrepeater/p' /etc/pistar-release | sed -E "s/[[:space:]]+//g")
m5=$(sudo sed -n '/^[^#]*MMDVMHost/p' /etc/pistar-release | sed -E "s/[[:space:]]+//g")
m6=$(sudo sed -n '/^[^#]*kernel/p' /etc/pistar-release | sed -E "s/[[:space:]]+//g")
m7=$(sudo sed -n '/^[^#]*Hardware/p' /etc/pistar-release | sed -E "s/[[:space:]]+//g")
#m8=$(sudo sed -n '/^[^#]version/p' /var/www/dashboard/config/version.php | sed -E "s/[[:space:]]+//g")
m8=$(sudo sed -n '/^[^#]*version/p' /var/www/dashboard/config/version.php | sed -E "s/[[:space:]]+//g" | sed -E "s/'//g" | sed -E "s/;//g" | cut -c2- | sed -E "s/version=/Dashboard:/g" )


mt="$m1|$m2|$m3|$m4|$m5|$m6|$m7|$m8"
echo "$mt"




