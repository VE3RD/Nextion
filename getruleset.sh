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
		echo "$m1"
	fi
	if [ "$1" = 12 ]; then
                m2=$(sudo sed -n '/^[ \t]*\[DMR Network '"$2"'\]/,/\[/s/^[ \t]*Name[ \t]*=[ \t]*//p' /etc/dmrgateway)
		echo "$m2"
	fi
	if [ "$1" = 13 ]; then
                m3=$(sudo sed -n '/^[ \t]*\[DMR Network '"$2"'\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/dmrgateway)
		echo "$m3"
	fi	


	if [ "$1" = 21 ]; then
		m10=$(sed -n '/^[ \t]*\[DMR Network '"$2"'\]/,/\[/s/^[ \t]*TGRewrite[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		echo "$m10"
         fi

	if [ "$1" = 22 ]; then
		m11=$(sed -n '/^[ \t]*\[DMR Network '"$2"'\]/,/\[/s/^[ \t]*PCRewrite[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		echo "$m11"
	fi

	if [ "$1" = 23 ]; then
		m12=$(sed -n '/^[ \t]*\[DMR Network '"$2"'\]/,/\[/s/^[ \t]*SrcRewrite[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		echo "$m12"
	fi

	if [ "$1" = 24 ]; then
		m13=$(sudo sed -n '/^[ \t]*\[DMR Network '"$2"'\]/,/\[/s/^[ \t]*PassAllTG[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		echo "$m13"
	fi

	if [ "$1" = 25 ]; then
		m10=$(sudo sed -n '/^[ \t]*\[DMR Network '"$2"'\]/,/\[/s/^[ \t]*PassAllPC[ \t]*=[ \t]*//p' /etc/dmrgateway)
		echo "$m14"
	fi

#	if [ "$1" = 19 ]; then
#		awk '/\[DMR Network '"$2"'\]/{flag=1;next;}/\[.*\]/{flag=0}flag && NF' /etc/dmrgateway
#
#         fi

fi;

