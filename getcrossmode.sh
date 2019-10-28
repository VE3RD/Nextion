#!/bin/bash
############################################################
#  Get Cross Mode Index for Cross Over                     #
#  $1 7-11 Select Mode to get status of                     #
#                                                          #
#  Returns the status Enable=0 or 1                        #
#                                                          #
#  KF6S                                        09-01-2019  #
############################################################
set -o errexit
set -o pipefail

if [ "$1" = 7 ]; then  
  	if pgrep -x "DMR2YSF" > /dev/null
        then
		echo "1"
	else
		echo "0"
	fi
fi

if [ "$1" = 8 ]; then
        if pgrep -x "DMR2NXDN" > /dev/null 
        then
		echo "1"
	else
		echo "0"
	fi
fi
if [ "$1" = 9 ]; then
        if pgrep -x "YSF2DMR" > /dev/null
        then
		echo "1"
        else
		echo "0"
        fi
fi
if [ "$1" = 10 ]; then
        if pgrep -x "YSF2NXDN" > /dev/null
        then
               echo "1"
        else
		echo "0"
        fi
fi
if [ "$1" = 11 ]; then
        if pgrep -x "YSF2P25" > /dev/null
        then
               echo "1"
        else
		echo "0"
        fi
fi

if pgrep -x "YSF2DMR" > /dev/null
then
    killall -9 YSF2DMR
fi

