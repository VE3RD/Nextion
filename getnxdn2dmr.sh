#!/bin/bash
############################################################
#  Get NXDN2DMR Cross Mode Parameters                      #
# 				                           #
#                                                          #
#  Returns a | separated string   	                   #
#                                                          #
#  VE3RD                                        2020-04-28 #
############################################################
set -o errexit
set -o pipefail

m1=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/nxdn2dmr)
m2=$(sed -nr "/^\[DMR Network\]/ { :1 /^Port[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
m3=$(sed -nr "/^\[DMR Network\]/ { :1 /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
m4=$(sed -nr "/^\[Network\]/ { :1 /^Startup[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/nxdngateway)
m5=$(sed -nr "/^\[DMR Network\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/nxdn2dmr)
m3=127.0.0.3
mt="$m1|$m2|$m3|$m4|$m5"
echo "$mt"

