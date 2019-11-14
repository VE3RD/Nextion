#!/bin/bash
############################################################
#  Get  Mode from /etc/dmrgateway                           #
#  $1 1-6 Select Mode to get status of                     #
#                                                          #
#  Returns the status Enable=0 or 1                        #
#                                                          #
#  KF6S                                        09-01-2019  #
############################################################
set -o errexit
set -o pipefail

declare -i m1
declare -i m2
declare -i m3
declare -i m4
declare -i m5
declare -i m6
declare -i mt
if [ -z "$1" ]; then
        exit
else
	if [ "$1" = 21 ]; then
		m1=$(sudo sed -n '/^[ \t]*\[DMR Network 1\]/,/\[/s/^[ \t]*Enabled[ \t]*=[ \t]*//p' /etc/dmrgateway)
		m2=$(sudo sed -n '/^[ \t]*\[DMR Network 2\]/,/\[/s/^[ \t]*Enabled[ \t]*=[ \t]*//p' /etc/dmrgateway)
		m3=$(sudo sed -n '/^[ \t]*\[DMR Network 3\]/,/\[/s/^[ \t]*Enabled[ \t]*=[ \t]*//p' /etc/dmrgateway)
		m4=$(sudo sed -n '/^[ \t]*\[DMR Network 4\]/,/\[/s/^[ \t]*Enabled[ \t]*=[ \t]*//p' /etc/dmrgateway)
		m5=$(sudo sed -n '/^[ \t]*\[DMR Network 5\]/,/\[/s/^[ \t]*Enabled[ \t]*=[ \t]*//p' /etc/dmrgateway)
		mt="$m1 + ($m2*2) + ($m3*4) + ($m4*8) + ($m5*16)"
		echo "$mt"
	fi

       
	if [ "$1" = 26 ]; then
		m10=$(sudo sed -n '/^[ \t]*\[DMR Network 1\]/,/\[/s/^[ \t]*Name[ \t]*=[ \t]*//p' /etc/dmrgateway)
       	 	m11=$(sudo sed -n '/^[ \t]*\[DMR Network 2\]/,/\[/s/^[ \t]*Name[ \t]*=[ \t]*//p' /etc/dmrgateway)
        	m12=$(sudo sed -n '/^[ \t]*\[DMR Network 3\]/,/\[/s/^[ \t]*Name[ \t]*=[ \t]*//p' /etc/dmrgateway)
        	m13=$(sudo sed -n '/^[ \t]*\[DMR Network 4\]/,/\[/s/^[ \t]*Name[ \t]*=[ \t]*//p' /etc/dmrgateway)
        	m14=$(sudo sed -n '/^[ \t]*\[DMR Network 5\]/,/\[/s/^[ \t]*Name[ \t]*=[ \t]*//p' /etc/dmrgateway)
		if [ -z $m13 ]; then
  			m13=na
		fi
		if [ -z $m14 ]; then
  			m14=na
		fi

#		m10=$(sudo expr length $m10):$m10 
#		m11=$(sudo expr length $m11):$m11 
#		m12=$(sudo expr length $m12):$m12 
#		m13=$(sudo expr length $m13):$m1 
#		m14=$(sudo expr length $m14):$m14 
		mts="$m10|$m11|$m12|$m13|$m14"
		echo "$mts"
	fi


        if [ "$1" = 31 ]; then
                m10=$(sudo sed -n '/^[ \t]*\[DMR Network 1\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m11=$(sudo sed -n '/^[ \t]*\[DMR Network 2\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m12=$(sudo sed -n '/^[ \t]*\[DMR Network 3\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m13=$(sudo sed -n '/^[ \t]*\[DMR Network 4\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m14=$(sudo sed -n '/^[ \t]*\[DMR Network 5\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/dmrgateway)
                if [ -z $m13 ]; then
                        m13=na
                fi
                if [ -z $m14 ]; then
                        m14=na
                fi

#                m10=$(sudo expr length $m10):$m10
#                m11=$(sudo expr length $m11):$m11
#                m12=$(sudo expr length $m12):$m12
#                m13=$(sudo expr length $m13):$m13
#                m14=$(sudo expr length $m14):$m14
                mts="$m10|$m11|$m12|$m13|$m14"
                echo "$mts"
        fi

fi;

