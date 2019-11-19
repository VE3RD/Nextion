#!/bin/bash
############################################################
#  Get  ModeHang from /etc/dmrgateway                      #
#  $1 1-6 Select Mode to get status of                     #
#                                                          #
#  Returns a String                                        #
#                                                          #
#  VE3RD                                     2019-11-14    #
############################################################
set -o errexit
set -o pipefail

#declare -i m1
#declare -i m2
#declare -i m3
#declare -i m4
#declare -i m5
#declare -i m6
#declare -i mt
if [ -z "$1" ]; then
        exit
        else
        if [ "$1" = 21 ]; then
		sed -nr "/^\[DMR\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost
	fi
        if [ "$1" = 22 ]; then
		sed -nr "/^\[NXDN\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost
        fi
	if [ "$1" = 23 ]; then
		sed -nr "/^\[System Fusion\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost
	fi
        if [ "$1" = 24 ]; then
		sed -nr "/^\[P25\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost
	fi	
        if [ "$1" = 25 ]; then
		sed -nr "/^\[D-Star\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost
	fi
fi;

