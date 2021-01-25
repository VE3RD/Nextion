#!/bin/bash
############################################################
#  Get  DMRGateway Start Parameters from /etc/dmrgateway   #
#                                                          #
#  Returns a | separated string                            #
#                                                          #
#  VE3RD                                     2019-11-14    #
############################################################
set -o errexit
set -o pipefail

#if [ -z "$1" ]; then
#        exit
#	else

 		 m1=$(sudo sed -n '/^[ \t]*\[General\]/,/\[/s/^[ \t]*StartNet[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
if [ -z "$m1" ]; then
echo "Missing StartNet"
#sudo mount -o remount,rw /
sed -i '/^\[General\]/,/^\[/ { x; /^$/ !{ x; H }; /^$/ { x; h; }; d; }; x; /^\[General\]/ { s/\(\n\+[^\n]*\)$/\nStartNet=4\1/; p; x; p; x; d }; x' /etc/dmrgateway
fi 
 		 m1=$(sudo sed -n '/^[ \t]*\[General\]/,/\[/s/^[ \t]*StartNet[^#; \t]*=[ \t]*//p' /etc/dmrgateway)

		m10=$(sudo sed -n '/^[ \t]*\[General\]/,/\[/s/^[ \t]*RuleTrace[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		m11=$(sudo sed -n '/^[ \t]*\[General\]/,/\[/s/^[ \t]*Daemon[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		m12=$(sudo sed -n '/^[ \t]*\[General\]/,/\[/s/^[ \t]*Debug[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		m13=$(sudo sed -n '/^[ \t]*\[Log\]/,/\[/s/^[ \t]*DisplayLevel[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		m14=$(sudo sed -n '/^[ \t]*\[Log\]/,/\[/s/^[ \t]*FileLevel[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		m15=$(sudo sed -n '/^[ \t]*\[Log\]/,/\[/s/^[ \t]*FilePath[^#; \t]*=[ \t]*//p' /etc/dmrgateway)
		m16=$(sudo sed -n '/^[ \t]*\[Log\]/,/\[/s/^[ \t]*FileRoot[^#; \t]*=[ \t]*//p' /etc/dmrgateway)

               mt="$m1|$m10|$m11|$m12|$m13|$m14|$m15|$m16"
              echo "$mt"

#fi;
sudo mount -o remount,ro /

