#!/bin/bash
############################################################
#  Get  Network info from /etc/dmrgateway                  #
#  $1 1-6 Select Mode to get status of                     #
#                                                          #
#  Returns a | separated group of Strings                  #
#                                                          #
#  VE3RD                                     2019-11-14    #
############################################################
set -o errexit
set -o pipefail

if [ -z "$1" ]; then
        exit
	else
	m1=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*Enabled[ \t]*=[ \t]*//p' /etc/dmrgateway)
        m2=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*Name[ \t]*=[ \t]*//p' /etc/dmrgateway)
        m3=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/dmrgateway)
        m4=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*Port[ \t]*=[ \t]*//p' /etc/dmrgateway)
        m5=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*Local[ \t]*=[ \t]*//p' /etc/dmrgateway)
        m6=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*Password[ \t]*=[ \t]*//p' /etc/dmrgateway)
        m7=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*Id[ \t]*=[ \t]*//p' /etc/dmrgateway)
	mt="$m1|$m2|$m3|$m4|$m5|$m6|$m7"
	echo "$mt"


fi;

