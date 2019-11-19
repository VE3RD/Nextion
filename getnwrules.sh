#!/bin/bash
############################################################
#  Get  Mode from /etc/dmrgateway                          #
#  $1 1-6 Select Mode to get status of                     #
#                                                          #
#  Returns a Binary Coded Number as a String               #
#                                                          #
#  VE3RD                                     2019-11-14    #
############################################################
set -o errexit
set -o pipefail

if [ -z "$1" ]; then
        exit
	else
	if [ "$1" = 11 ]; then
		m1=$(sudo sed -n '/^[ \t]*\[DMR Network '"$2"'\]/,/\[/s/^[ \t]*Enabled[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m2=$(sudo sed -n '/^[ \t]*\[DMR Network '"$2"'\]/,/\[/s/^[ \t]*Name[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m3=$(sudo sed -n '/^[ \t]*\[DMR Network '"$2"'\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m4=$(sudo sed -n '/^[ \t]*\[DMR Network '"$2"'\]/,/\[/s/^[ \t]*Port[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m5=$(sudo sed -n '/^[ \t]*\[DMR Network '"$2"'\]/,/\[/s/^[ \t]*Local[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m6=$(sudo sed -n '/^[ \t]*\[DMR Network '"$2"'\]/,/\[/s/^[ \t]*Password[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m7=$(sudo sed -n '/^[ \t]*\[DMR Network '"$2"'\]/,/\[/s/^[ \t]*Id[ \t]*=[ \t]*//p' /etc/dmrgateway)
		mt="$m1|$m2|$m3|$m4|$m5|$m6|$m7"
		echo "$mt"
	fi       

#	if [ "$1" = 19 ]; then
#		awk '/\[DMR Network '"$2"'\]/{flag=1;next;}/\[.*\]/{flag=0}flag && NF' /etc/dmrgateway
#
#         fi

fi;

