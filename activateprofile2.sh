#!/bin/bash
############################################################
#  Activate  Profile                                       #
#  VE3RD                                      2019/11/18   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
fmm="/etc/mmdvmhost_t"
fgate="/etc/dmrgateway"
fysf="/etc/ysfgateway"
fy2d="/etc/ysf2dmr"
fd2y="/etc/dmr2ysf"
nsp="/usr/local/etc/Nextion_Support/profiles2.txt"
pnum="$1"
declare -i n=1
section=""

fname=tba
profile="Profile $1"

List1=$(grep "$profile" -A 20 "$nsp")

function loopall
{
n=1
i=1
stat="false"

while [[ "$stat"="false" ]]
do

#for n in {1..20}
#do
	ok=false
	param=""	

	var1=$(awk 'c&&!--c;/'"$profile"'/{c='$n'}' "$nsp")
#	echo "$var1"

	if [ ! "$var1" ]; then
 	   	exit
	fi

	if [[ ${var1:0:3} = "///" ]]; then
		stat="done"
		var1=""
	fi

	if [[ ${var1:0:5} = "/etc/" ]]; then
#		echo "File:$var1"
		fname="$var1"
		var1=""
	fi

	if [[ ${var1:0:1} = "[" ]]; then
		var1=${var1:1:-1}
		section="$var1"
		var1=""
	fi

	pval=""
	param=""
	
	param=$(echo "$var1" | cut -d'=' -f1)
	pval=$(echo "$var1" | cut -d'=' -f2)

## Get specialty Passwords	
	if [[ "$pval" = "PRIMEPW" ]]; then
		 pval=$(sudo sed -n '/'"prime"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f4)
	fi

	if [[ "$pval" = "MNETPW" ]]; then
		 pval=$(sudo sed -n '/'"mnet"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g"  | cut -d'|' -f4)
	fi

	if [[ "$pval" = "BMPW" ]]; then
		pval=$(sudo grep Password  /etc/dstar-radio.mmdvmhost | cut -d'=' -f2)
	fi
	if [[ "$param" = "Mode" ]]; then
		param=""
		pval=""
	fi


	slen=${#param} 

	if [ "$slen" != 0 ]; then
		sudo sed -i '/^\[/h;G;/^'"$section"'/s/\(^ModeHang=\).*/\125/m;P;d'  /etc/mmdvmhost_t
		echo "Setting $profile [$section] $param=$pval"
	fi
n=n+1
done

}

loopall "$1" 

