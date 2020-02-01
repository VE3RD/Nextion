#!/bin/bash
############################################################
#  Get YSF2DMR Cross Mode Parameters 		           #
#  Build a | separated String                              #
#                                                          #
#                                                          #
#  VE3RD                                        2019-11-14 #
############################################################
set -o errexit
set -o pipefail

m1=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)
m2=$(sed -nr "/^\[YSF Network\]/ { :1 /^EnableWiresX[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)
m3=$(sed -nr "/^\[DMR Network\]/ { :1 /^Port]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)
m4=$(sed -nr "/^\[DMR Network\]/ { :1 /^Address]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)
m5=$(sed -nr "/^\[DMR Network\]/ { :1 /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)
m6=$(sed -nr "/^\[DMR Network\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)
mt="$m1|$m2|$m3|$m4|$m5|$m6"
echo "$mt"

