#!/bin/bash
############################################################
#  Get Cross Mode 			                   #
#  Build Binary Bit Pattern                                #
#                                                          #
#  Returns a number as a string		                   #
#                                                          #
#  VE3RD                                        2019-11-14 #
############################################################
set -o errexit
set -o pipefail

m1=$(sed -nr "/^\[DMR Network\]/ { :1 /^DefaultDstTG]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/dmr2ysf)
m2=$(sed -nr "/^\[Network\]/ { :1 /^Startup[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/nxdngateway)
m3=$(sed -nr "/^\[DMR Network\]/ { :1 /^Address]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)
m4=$(sed -nr "/^\[DMR Network\]/ { :1 /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)
m5=$(sed -nr "/^\[NXDN Network\]/ { :1 /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2nxdn)
m6=$(sed -nr "/^\[NXDN Network\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2nxdn)
m7=$(sed -nr "/^\[P25 Network\]/ { :1 /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2p25)
mt="$m1|$m2|$m3|$m4|$m5|$m6|$m7"
echo "$mt"

