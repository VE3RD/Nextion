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
		m17=$(sed -nr "/^\[Voice\]/ { :1 /^Enable[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/dmrgateway)
                m18=$(sed -nr "/^\[Voice\]/ { :l /^Language[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
                m19=$(sed -nr "/^\[Voice\]/ { :l /^Directory[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
		echo "$m17|$m18|$m19"
#fi;

 
