#!/bin/bash
#########################################################
#  Nextion Support for Nextion screen. Used to dump     #
#  current TG and change to TG4000                      #
#  Check Firewall added by VE3RD			#
#		                                        #
#  K5MRE & KF6S & VE3RD                     05-01-2019  #
#########################################################
# Use passed TS if present or default to TS2 (zero based code=1)
if [ -z "$1" ]; then
TS="1"
else
TS=$1
fi

timeout 1 bash -c 'cat < /dev/null > /dev/tcp/tgif.network/5040'

if  [ $? = 0 ]; then
	TG=4000
	#ID=`sudo cat /etc/mmdvmhost | grep "DMR" -A 12 | grep "Id=" | cut -b 4-14`
	ID=$(sed -nr "/^\[DMR\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
	curl -s http://tgif.network:5040/api/sessions/update/$ID/$TS/$TG
	## To check arquments being passed to command take off the ## in front of echo below
	#echo curl -s http://tgif.network:5040/api/sessions/update/$ID/$TS/$TG
else
  echo 5040
#  echo Check Firewall Rule 5040
	sudo sh -c 'echo "iptables -A OUTPUT -p tcp --dport 5040 -j ACCEPT" > /root/ipv4.fw'
	sudo pistar-firewall

fi

