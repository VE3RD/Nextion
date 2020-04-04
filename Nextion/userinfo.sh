#!/bin/bash
############################################################
#  Lookup DMR Master IP in /usr/local/etc/DMR_Hosts.txt    #
#  Return IP Address.                                      #
#                                                          #
#                                                          #
#  KF6S                                        05-20-2019  #
############################################################
set -o errexit
set -o pipefail
# Use passed DMR Master name to lookup IP address
declare LEN number


m1=$(sed -nr "/^\[General\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
m2=$(sed -nr "/^\[Enabled\]/ { :1 /^Callsign[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
m3=$(sudo sed -n '/^[^#]*'"$m1"'/p' /usr/local/etc/DMRIds.dat | sed -E "s/[[:space:]]+/|/g")

m4=$(sudo cat /usr/local/etc/Nextion_Support/user.txt)

echo "$m3|$m4"
