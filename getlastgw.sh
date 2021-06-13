#!/bin/bash
#################################################
#  Get Last Heard Network from DMRGateway	#
#						#
#						#
#  VE3RD 			2020-11-29	#
#################################################
set -o errexit
set -o pipefail

#f1=$(ls -tr /var/log/pi-star/DMRG*)
f1=$(ls  /var/log/pi-star/DMRGateway* | tail -n1)

#echo "$f1"
NetType=$(sudo tail -n1 "$f1" | cut -d " " -f 4)
#echo "$NetType"
NetNum=$(sudo tail -n1 "$f1" | cut -d " " -f 6)
#echo "$NetNum"

#echo "$NetType: $NetNum"
if [ "$NetType" = "RFRX" ]; then
   echo "GW RF Net: $NetNum"
else
   echo "GW RX Net: $NetNum"
fi


exit

tt1=$(sudo grep -i 'Network' "$f1" | tail -n5 | cut -d " " -f 7)
echo "$tt1"

if [ ! "$tt2" ]; then
 	tt2=$(sudo grep -i 'RF' "$f1" | tail -n5 | cut -d " " -f9)
 	echo "$tt2"
fi
exit
tt0=$(echo "$tt" | cut -d' ' -f4)
#echo "2:$tt0"

if [ "$tt0" = "RF" ]; then
	tt1=$(echo "$tt" | cut -d' ' -f6 | cut -d'=' -f2 | cut -d'_' -f1)
	tt2=$(echo "$tt" | cut -d' ' -f6 | cut -d'=' -f2 | cut -d'_' -f2)
	echo "R $tt1 $tt2" 
fi
if [ "$tt0" = "Network" ]; then
	t1=$(echo "$tt" | cut -d' ' -f8 | cut -d'=' -f2 | cut -d'_' -f1)
	t2=$(echo "$tt" | cut -d' ' -f8 | cut -d'=' -f2 | cut -d'_' -f2)
	echo "N $t1 $t2"
fi

