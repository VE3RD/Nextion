#!/bin/bash
###############################################################
# Support for Nextion Screen to format ESSID list for screen  #
#                                                             #
#                                                             #
#                                                             #
#                                                             #
# VE3RD                                           2020--4-11  #
###############################################################

if [ -z "$1" ]; then
exit
fi

#iwlist wlan0 scan | grep 'ESSID' | sed 's/.*ESSID:"\(.*\)".*/\1/g' | tr " " "\n"|sed -n '1p'
main=$(iwlist wlan0 scan | grep 'ESSID' | sed 's/.*ESSID:"\(.*\)".*/\1/g')

if [ "$1" == "1" ]; then
p1=$(echo "$main" | sed -n '1p')
p2=$(echo "$main" | sed -n '2p')
p3=$(echo "$main" | sed -n '3p')
p4=$(echo "$main" | sed -n '4p')
p5=$(echo "$main" | sed -n '5p')
echo "$p1|$p2|$p3|$p4|$p5"
fi

if [ "$1" == "2" ]; then
p1=$(echo "$main" | sed -n '6p')
p2=$(echo "$main" | sed -n '7p')
p3=$(echo "$main" | sed -n '8p')
p4=$(echo "$main" | sed -n '9p')
p5=$(echo "$main" | sed -n '10p')
echo "$p1|$p2|$p3|$p4|$p5"
fi

if [ "$1" == "3" ]; then
p1=$(echo "$main" | sed -n '11p')
p2=$(echo "$main" | sed -n '12p')
p3=$(echo "$main" | sed -n '13p')
p4=$(echo "$main" | sed -n '14p')
p5=$(echo "$main" | sed -n '15p')
echo "$p1|$p2|$p3|$p4|$p5"
fi




