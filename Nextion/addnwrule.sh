#!/bin/bash
############################################################
#  Get  Gateway Network ReWrite Rules in /etc/dmrgateway   #
#                                                          #
#  UNDER CONSTRUCTION                                      #
#                                                          #
#  VE3RD                                     2019-11-20    #
############################################################
set -o errexit
set -o pipefail

sudo mount -o remount,rw /

key1="TGRewrite"
val1="2,1,2,1,99999"
#sed '/^\[section1\]/,/^\[/ { x; /^$/ !{ x; H }; /^$/ { x; h; }; d; }; x; /^\[section1\]/ { s/\(\n\+[^\n]*\)$/\nkey10=value10\1/; p; x; p; x; d }; x' foo.ini
mt=$(sed  -i '/^\[/h;G;/DMR Network '"$1"'\]/,/^\[/ { x; /^$/ !{ x; H }; /^$/ { x; h; }; d; }; x; /^\[DMR Network '"$1"'\]/ { s/\(\n\+[^\n]*\)$/\n'"$key1"'='"$val1"'\1/; p; x; p; x; d }; x' /etc/dmrgateway)
# mt=$( sudo sed -i '/^\[/h;G;/DMR Network '
sudo mount -o remount,ro /
