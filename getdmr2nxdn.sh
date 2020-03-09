#!/bin/bash
############################################################
#  Get DMR2NXDN Cross Mode 		                   #
# 				                           #
#                                                          #
#  Returns a | separated string   	                   #
#                                                          #
#  VE3RD                                        2019-11-14 #
############################################################
set -o errexit
set -o pipefail

m1=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/dmr2nxdn)
m2=$(sed -nr "/^\[DMR Network\]/ { :1 /^Port[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
m3=$(sed -nr "/^\[DMR Network\]/ { :1 /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
m4=$(sed -nr "/^\[Network\]/ { :1 /^Startup[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/nxdngateway)
m5=$(sed -nr "/^\[DMR Network\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/dmr2nxdn)
m3=127.0.0.3
mt="$m1|$m2|$m3|$m4|$m5"
echo "$mt"

