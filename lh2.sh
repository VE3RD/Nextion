#!/bin/bash
#################################################
#  Get Last Heard Liost from MMDVMHost Log	#
#						#
#						#
#  VE3RD 			2020-05-03	#
#################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

if [ -f /home/pi-star/lh2_start.txt ]; then
  rm /home/pi-star/lh2_start.txt
fi
if [ -f /home/pi-star/lhlog.txt ]; then
  rm /home/pi-star/lhlog.txt
fi

echo "Args = $@" >> /home/pi-star/lh2_start.txt

name=""

declare -i n
####################################################
function domode2
{
line3=""
while read -r line
do
	call=$(echo "$line" | cut -d' ' -f3)
	tm=$(echo "$line" | cut -d' ' -f2)
	pl=$(echo "$line" | cut -d' ' -f5)

	echo "Add Call: $call" >> /home/pi-star/lh2_start.txt
	dataline=$(sudo sed -n "/$call/p" /usr/local/etc/stripped.csv)

	did=$(echo "$dataline" | cut -d',' -f1)
	name=$(echo "$dataline" | cut -d',' -f3)

	line2=$(echo "$line $name $did" | awk '{printf  "%5s %.5s %6s %7s %6s %6s\n",$1,$2,$3,$6,$4,$7,"   "}')
	line3=${line2:0:37}
	line4=$(echo "$line3" | tr -d "\n") 
	list5+="$line4"
done <<< "$list9"
var="${list5:0:240}"
echo "${var}"
echo "${var}" >> ./lh2_start.txt

#echo "$list3"
}

##########################################################
function domode3
{
line3=""
while read -r line
do
	call=$(echo "$line" | cut -d' ' -f3)
	tm=$(echo "$line" | cut -d' ' -f2)
	pl=$(echo "$line" | cut -d' ' -f5)

	echo "Add Call: $call" >> /home/pi-star/lh2_start.txt
	dataline=$(sudo sed -n "/$call/p" /usr/local/etc/stripped.csv)
       	did=$(echo "$dataline" | cut -d',' -f1 | head -1)
        name=$(echo "$dataline" | cut -d',' -f3 | head -1)
        city=$(echo "$dataline" | cut -d',' -f4 | head -1)
        prov=$(echo "$dataline" | cut -d',' -f5 | head -1)
        country=$(echo "$dataline" | cut -d',' -f7 | head -1)
	spc="        "
	line3=$(echo "$call" "$name" "$city" "$prov" "$country" "$spc" | awk '{printf  "%s %s %s %s %s %s\n", $call, $name, $city, $prov, $country, $spc}')
#	echo "$line2"
	line4=${line3:0:37}
	line6=$(echo "$line4" | tr -d "\n")

	list5+="$line6"
done <<< "$list9"
var="${list5:0:240}"
echo "${var}"
echo "${var}" >> ./lh2_start.txt

#echo "$list3"
}
##################################################
function domode4
{
line3=""
while read -r line
do
	call=$(echo "$line" | cut -d' ' -f3)
	tm=$(echo "$line" | cut -d' ' -f2)
	pl=$(echo "$line" | cut -d' ' -f5)

#	echo "Add Call: $call" >> /home/pi-star/lh2_start.txt
	dataline=$(sudo sed -n "/$call/p" /usr/local/etc/stripped.csv)
        name=$(echo "$dataline" | cut -d',' -f3 | head -1)
       	did=$(echo "$dataline" | cut -d',' -f1 | head -1)

	line2=$(echo "$line $name $did" | awk '{printf  "%5s %.5s %6s %7s %6s %6s\n",$1,$2,$3,$6,$4,$7,"   "}')
#	echo "  $line2"
	line3=${line2:0:37}
	list4+="$line3"
done <<< "$list9"
var="${list4:0:240}"
echo "${var}"
echo "${var}" >> ./lh2_start.txt

#echo "$list3"
exit
}

#######################################################################



######################################
#Start of Main Program
######################################

f1=$(ls -tr /var/log/pi-star/MMDVM* | tail -1)
list1=$(sudo sed -n '/received network end of voice transmission from/p' $f1 | sed 's/,//g' | sort -r -k14,14 -k2,3)

f2=$(ls -tr /var/log/pi-star/MMDVM* | head -1)
list2=$(sudo sed -n '/received network end of voice transmission from/p' $f2 | sed 's/,//g' | sort -r -k14,14 -k2,3)
#echo "$list1"
list3=$(echo "$list1" | awk '$14!=savestr {print substr($2,6,5),substr($3,0,6),$14,$17,$6,$18,$20; savestr=$14}' | sort -r -k1,2)
list4=$(echo "$list2" | awk '$14!=savestr {print substr($2,6,5),substr($3,0,6),$14,$17,$6,$18,$20; savestr=$14}' | sort -r -k1,2)

lcnt=$(echo "$list3" | wc -l)
if [ $lcnt -lt 20 ]; then
	list3+=$list4
fi

######  Mode 1
if [ "$2" == "1" ]; then
#		echo "Check OK 1 = $2" >> /home/pi-star/lh2_start.txt 

	if [ "$1" == "1" ]; then
		echo "$list3" | sed -n '1,6p;7q' |  awk '{printf "%5s %5s %6s %6s %1s %4s %-4s\n", $1, $2, $3, $4, $5, $6, $7}' | tr -d "\n"
	fi
	if [ "$1" == "2" ]; then
		echo "$list3" | sed -n '7,12p;12q' |  awk '{printf "%5s %5s %6s %6s %1s %4s %-4s\n", $1, $2, $3, $4, $5, $6, $7}' | tr -d "\n"
	fi
	if [ "$1" == "3" ]; then
		echo "$list3" | sed -n '13,18p;19q' |  awk '{printf "%5s %5s %6s %6s %1s %4s %-4s\n", $1, $2, $3, $4, $5, $6, $7}' | tr -d "\n"
	fi
	if [ "$1" == "4" ]; then
		echo "$list3" | sed -n '19,24p;25q' |  awk '{printf "%5s %5s %6s %6s %1s %4s %-4s\n", $1, $2, $3, $4, $5, $6, $7}' | tr -d "\n"
	fi
fi
######  Mode 2

if [ "$2" == "2" ]; then
                echo "Check OK 2 = $2" >> /home/pi-star/lh2_start.txt

	if [ "$1" == "1" ]; then
		list9=$(echo "$list3" | sed -n '1,6p;7q' | awk '{print $1, $2, $3, $3}' )
	fi
	if [ "$1" == "2" ]; then
		list9=$(echo "$list3" | sed -n '7,12p;13q' | awk '{print $1, $2, $4, $5}') 
	fi
	if [ "$1" == "3" ]; then
		list9=$(echo "$list3" | sed -n '13,18p;19q' | awk '{print $1, $2, $4, $5}') 
	fi
	if [ "$1" == "4" ]; then
		list9=$(echo "$list3" | sed -n '19,24p;25q' | awk '{print $1, $2, $4, $5}') 
	fi

	domode2
fi
#####  Mode 3
if [ "$2" == "3" ]; then
        echo "Check OK 3 = $2" >> /home/pi-star/lh2_start.txt

	if [ "$1" == "1" ]; then
		list9=$(echo "$list3" | sed -n '1,6p;7q' | awk '{print $1, $2, $3, $4}' )
	fi

	if [ "$1" == "2" ]; then
		list9=$(echo "$list3" | sed -n '7,12p;13q' | awk '{print $1, $2, $4,$5}') 
	fi
	if [ "$1" == "3" ]; then
		list9=$(echo "$list3" | sed -n '13,18p;19q' | awk '{print $1, $2, $4, $5}') 
	fi
	if [ "$1" == "4" ]; then
		list9=$(echo "$list3" | sed -n '19,24p;25q' | awk '{print $1, $2, $4, $5}') 
	fi

	domode3
fi


if [ "$2" == "4" ]; then
        echo "Check OK 3 = $2" >> /home/pi-star/lh2_start.txt

	if [ "$1" == "1" ]; then
		list9=$(echo "$list3" | sed -n '1,6p;7q' | awk '{print $1, $2, $4, $5}' )
	fi

	if [ "$1" == "2" ]; then
		list9=$(echo "$list3" | sed -n '7,12p;13q' | awk '{print $1, $2, $4,$5}') 
	fi
	if [ "$1" == "3" ]; then
		list9=$(echo "$list3" | sed -n '13,18p;19q' | awk '{print $1, $2, $4, $5}') 
	fi
	if [ "$1" == "4" ]; then
		list9=$(echo "$list3" | sed -n '19,24p;25q' | awk '{print $1, $2, $4, $5}') 
	fi

	domode4

fi

