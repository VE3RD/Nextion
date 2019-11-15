#!/bin/bash
############################################################
#  Get  Mode from /etc/mmdvmhost                           #
#                                                          #
#  Returns a Binary Coded Value                            #
#                                                          #
#  VE3RD                                      2019-11-14   #
############################################################
set -o errexit
set -o pipefail

declare -i m1
declare -i m2
declare -i m3
declare -i m4
declare -i m5
declare -i m6
declare -i mt

m1=$(sudo cat /etc/mmdvmhost | grep "\[D-Star\]" -A 1 | grep "Enable=" | cut -b 8-9)
m2=$(sudo cat /etc/mmdvmhost | grep "\[DMR\]" -A 1 | grep "Enable=" | cut -b 8-9)
m3=$(sudo cat /etc/mmdvmhost | grep "\[System Fusion\]" -A 1 | grep "Enable=" | cut -b 8-9)
m4=$(sudo cat /etc/mmdvmhost | grep "\[P25\]" -A 1 | grep "Enable=" | cut -b 8-9)
m5=$(sudo cat /etc/mmdvmhost | grep "\[NXDN\]" -A 1 | grep "Enable=" | cut -b 8-9)
m6=$(sudo cat /etc/mmdvmhost | grep "\[POCSAG\]" -A 1 | grep "Enable=" | cut -b 8-9)
mt="$m1 + ($m2*2) + ($m3*4) + ($m4*8) + ($m5*16) + ($m6*32)"

echo "$mt"


