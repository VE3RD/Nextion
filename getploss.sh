#!/bin/bash
#################################################
#  Get Packet Loss from MMDVMHost Log	        #
#						#
#						#
#  VE3RD 			2020-11-30	#
#################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

f1=$(ls -tr /var/log/pi-star/MMDVM* | tail -1)
MList1=$(sudo sed -n '/packet loss/p' $f1 | sed 's/,//g' | tail -1)

PLoss=$(echo "$MList1" | cut -d' ' -f20)
echo "PLoss:$PLoss"

