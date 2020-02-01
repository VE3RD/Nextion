#!/bin/bash
############################################################
#  Get YSF2NXDN Cross Mode Parameters 		           #
#  Build a | separated String                              #
#                                                          #
#                                                          #
#  VE3RD                                        2019-11-27 #
############################################################
set -o errexit
set -o pipefail

m1=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2nxdn)
m2=$(sed -nr "/^\[YSF Network\]/ { :1 /^EnableWiresX[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2nxdn)
m3=$(sed -nr "/^\[DMR Network\]/ { :1 /^Port]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
m4=$(sed -nr "/^\[DMR Network\]/ { :1 /^Address]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
m5=$(sed -nr "/^\[NXDN Network\]/ { :1 /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2nxdn)
m6=$(sed -nr "/^\[Network\]/ { :1 /^Startup[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysfgateway)
m7=$(sed -nr "/^\[DMR]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
mt="$m1|$m2|$m3|$m4|$m5|$m6|$m7"
echo "$mt"

