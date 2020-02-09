#!/bin/bash
#########################################################
#  Routine to determin the run time of a scipt          #
#  $1 = script Name 					#
#  $2 - parameter					#
#                                                       #
#  VE3RD                              2020-02-08        #
#########################################################
if [ ! "$1" ]; then
exit
fi 

start=$(date +%s.%N)

# Here you can place your function
sudo $1 $2 
duration=$(echo "$(date +%s.%N) - $start" | bc)
execution_time=`printf "%.2f seconds" $duration`

echo "Script Completed: $execution_time"



