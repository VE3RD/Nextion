#!/bin/bash
#########################################################
#  Nextion Support for Nextion screen. Used to dump     #
#  current TG and change to TG4000                      #
#  Check Firewall added by VE3RD			#
#		                                        #
#  K5MRE & KF6S & VE3RD                     05-01-2019  #
#########################################################
# Use passed TS if present or default to TS2 (zero based code=1)
#P1=TG,    P2=ID String,    P3=TS  0=TS1, 1=TS2

if [ -z "$2" ]; then
TS=1
else
TS=$2
fi

if [ -z "$3" ]; then
TG=4000
else
TG=$3
fi

if [ -z "$1" ]; then
TG=4000
else
TG=$1
fi

timeout 1 bash -c 'cat < /dev/null > /dev/tcp/tgif.network/5040'

if  [ $? = 0 ]; then
	ADDR=$(sed -nr "/^\[DMR Network\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
	if [ $ADDR = 127.0.0.1 ]; then
		ID=$(sed -nr "/^\[DMR Network 4\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)	
	
	else
		ID=$(sed -nr "/^\[DMR\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
	fi

	curl -s http://tgif.network:5040/api/sessions/update/$ID/$TS/$TG
	## To check arquments being passed to command take off the ## in front of echo below
	#echo curl -s http://tgif.network:5040/api/sessions/update/$ID/$TS/$TG
else
  echo 5040
  echo Check Firewall Rule 5040
fi

