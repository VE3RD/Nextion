#!/bin/bash
############################################################
#  Get RX Offset from mmdvmhost			           #
#  Build Binary Bit Pattern                                #
#                                                          #
#  Returns a number as a string		                   #
#                                                          #
#  VE3RD                                        2020-04-27 #
############################################################
set -o errexit
set -o pipefail

sed -nr "/^\[Modem\]/ { :1 /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost


