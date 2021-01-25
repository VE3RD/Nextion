#!/bin/bash
#################################################
#  Get Last Heard Network from DMRGateway	#
#						#
#						#
#  VE3RD 			2020-11-29	#
#################################################
set -o errexit
set -o pipefail

f1=$(ls -tr /var/log/pi-star/DMRG*)
#echo "File: $f1"
tt=$(grep Name= $f1 | tail -n1)
#echo "1:$tt"
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

