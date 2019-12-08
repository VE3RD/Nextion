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
		m1=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*Enabled[ \t]*=[ \t]*//p' /etc/dmrgateway)
		m10=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*TGRewrite.[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		m11=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*PCRewrite.[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		m12=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*SrcRewrite[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		m13=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*PassAllTG.[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		m14=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*PassAllPC.[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		m15=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*Location[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		m16=$(sudo sed -n '/^[ \t]*\[DMR Network '"$1"'\]/,/\[/s/^[ \t]*Debug[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
               mt="$m1|$m10|$m11|$m12|$m13|$m14|$m15|$m16"
              echo "$mt"
fi;

