#!/bin/bash
############################################################
#  Get Master Server 			                   #
#  $1 7-11 Select Mode to get status of                    #
#                                                          #
#  Returns a string		                           #
#                                                          #
#  KF6S                                        09-01-2019  #
############################################################
set -o errexit
set -o pipefail
declare -i m1
declare -i m2
declare -i m3
declare -i m4
declare -i m5
declare -i mt

m1=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/dmr2ysf)
m2=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/dmr2nxdn)
m3=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)
m4=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2nxdn)
m5=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2p25)
mt="$m1 + ($m2*2) + ($m3*4) + ($m4*8) + ($m5*16)"
echo "$mt"


