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

if [ "$1" = 7 ]; then  sudo cat /etc/dmr2ysf | grep "\[Enabled\]" -A 1 | grep "Enabled=" | cut -b 9-10
fi

if [ "$1" = 8 ]; then  sudo cat /etc/dmr2nxdn | grep "\[Enabled\]" -A 1 | grep "Enabled=" | cut -b 9-10
fi

if [ "$1" = 9 ]; then  sudo cat /etc/ysf2dmr | grep "\[Enabled\]" -A 1 | grep "Enabled=" | cut -b 9-10
fi

if [ "$1" = 10 ]; then  sudo cat /etc/ysf2nxdn | grep "\[Enabled\]" -A 1 | grep "Enabled=" | cut -b 9-10
fi

if [ "$1" = 11 ]; then  sudo cat /etc/ysf2p25 | grep "\[Enabled\]" -A 1 | grep "Enabled=" | cut -b 9-10
fi


