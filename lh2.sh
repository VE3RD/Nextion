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

echo "Args = $@" >> /home/pi-star/lh2_start.txt

name=""

declare -i n

function adddidname
{
while read -r line
do
	echo "Add Line:  $line" >> /home/pi-star/lh2_start.txt
#	line=$(echo "$line")

	call=$(echo "$line" | cut -d' ' -f3)
	tm=$(echo "$line" | cut -d' ' -f2)
	pl=$(echo "$line" | cut -d' ' -f5)

	echo "Add Call: $call" >> /home/pi-star/lh2_start.txt

#	name=$(sudo sed -n "/$call/p" /usr/local/etc/DMRIds.dat | sed -E "s/[[:space:]]+/|/g" | head -1 | cut -d'|' -f3)
	name=$(sudo sed -n "/$call/p" /usr/local/etc/DMRIds.dat | sed -E "s/[[:space:]]+/|/g" | cut -d'|' -f3 | head -1)
#	echo "Add Name: $name" >> /home/pi-star/lh2_start.txt
	did=$(sudo sed -n "/$call/p" /usr/local/etc/DMRIds.dat | sed -E "s/[[:space:]]+/|/g" | head -1 | cut -d'|' -f1)
	
	echo "Add DId: $did" >> /home/pi-star/lh2_start.txt


	line2=$(echo "Test 1 $line $name $did $pl              ")
#	line2=$(echo "$line $name $did         ")
	line2=$(echo "$line $name $did" | awk '{printf  "%5s %.5s %6s %10s %7s %s\n",$1,$2,$3,$6,$7," "}')
#	echo "$line2"
	line3=${line2:0:37}
	list3+=$line3
#	echo "$line3"
done <<< "$list2"

var="${list3:0:230}"
echo "${var}"
echo "${var}" >> ./lh2_start.txt
#echo "$list3"
}


f2=$(ls -tr /var/log/pi-star/MMDVM* | head -1)
f1=$(ls -tr /var/log/pi-star/MMDVM* | tail -1)
#echo "$f1"
#echo "$f2"

list1=$(sudo sed -n '/received network end of voice transmission from/p' $f1 | sed 's/,//g' | sort -k14)
list2=$(sudo sed -n '/received network end of voice transmission from/p' $f2 | sed 's/,//g' | sort -k14)

n=0 
echo " Test 1a = $1"  >> /home/pi-star/lh2_start.txt

	if [ "$2" == "1" ]; then
		echo "Check OK 1 = $2" >> /home/pi-star/lh2_start.txt 
		list3=$(echo "$list1" | awk 'spc="  " && $14!=savestr {printf "%5s %.5s %7s %5s %5s %4s %s\n",substr($2,6,5),$3,$14,$17,$18,$20,""; savestr=$14}' | sort -r)
		list4=$(echo "$list2" | awk 'spc="  " && $14!=savestr {printf "%5s %.5s %7s %5s %5s %4s %s\n",substr($2,6,5),$3,$14,$17,$18,$20,""; savestr=$14}' | sort -r )
  		list1=""
		list2=""
#		echo "$list1"
		list3+=$list4
		echo "mode $1 $2" >> ./lh2_start.txt
		if [ "$1" == "1" ]; then
			echo "$list3" | head -6 | tr -d "\n"
		fi
		if [ "$1" == "2" ]; then
			echo "$list3" | head -12 | tail -5 | tr -d "\n"
		fi
		if [ "$1" == "3" ]; then
			echo "$list3" | head -18 | tail -5 | tr -d "\n"
		fi

	fi

	if [ "$2" == "2" ]; then
                echo "Check OK 2 = $2" >> /home/pi-star/lh2_start.txt
                list2=$(echo "$list1" |  awk '$14!=savestr {print substr($2,6,5),substr($3,0,6),$14,$17,$20; savestr=$14}' | sort -r | head -6 )
                echo "mode $1 $2" >> ./lh2_start.txt
		#echo "PreTest list2 $list2" >> /home/pi-star/lh2_start.txt
		adddidname
	fi





