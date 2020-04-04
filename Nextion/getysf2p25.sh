#!/bin/bash
############################################################
#  Get YSF2P25 Cross Mode Parameters 		           #
#  Build a | separated String                              #
#                                                          #
#                                                          #
#  VE3RD                                        2019-11-27 #
############################################################
set -o errexit
set -o pipefail

if [ -z "$1" ]; then
m1=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2p25)
m2=$(sed -nr "/^\[YSF Network\]/ { :1 /^EnableWiresX[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2p25)
m3=$(sed -nr "/^\[YSF Network\]/ { :1 /^LocalPort]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2p25)
m4=$(sed -nr "/^\[YSF Network\]/ { :1 /^YSF2P25Address]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysfgateway)
m5=$(sed -nr "/^\[P25 Network\]/ { :1 /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2p25)
m6=$(sed -nr "/^\[Network\]/ { :1 /^Startup[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysfgateway)
m7=$(sed -nr "/^\[P25 Network\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2p25)

else
m3=42015
m4=127.0.0.1
fi 
#m4="YSF2P25"
mt="$m1|$m2|$m3|$m4|$m5|$m6|$m7"
echo "$mt"

