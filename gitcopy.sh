#!/bin/bash
#########################################################
#  Nextion TFT Support for Nextion 2.4" 		#
#  Gets all Scripts and support files from github       #
#  and copies them into the Nextion_Support directory   "
#  and copies the NX??? tft file into /usr/local/etc    #
#  and returns a script duration time to the Screen 	#
#  as a script completion flag				#
#							#
#  KF6S/VE3RD                               2020=02-09  #
#########################################################
# Use screen model from command $1
# Valid Screen Names for EA7KDO - NX3224K024, NX4832K935
# Valid Screen Names for VE3RD - NX3224K024

declare -i tst

if [ -z "$1" ]; then
	echo "No Screen Name Provided"
	exit
fi
if [ -z "$2" ]; then
	echo "No User Name Provided"
	echo "User Name must EA7KDO or VE3RD"
	exit
fi


scn="$1"
scn="${scn:0:10}"

if [ "$2" == "EA7KDO" ] || [ "$2" == "ea7kdo" ]; then
	calls="EA7KDO"
fi 
if [ "$2" == "VE3RD" ] || [ "$2" == "ve3rd" ]; then
	calls="VE3RD"
fi 

fb="$3"

#echo "$scn"


function exitcode
{
	echo "$scn"
	echo "Program Execution Halted"
	exit

}

function getea7kdo
{
#	echo "Function EA7KDO"

    	if [ "$scn" = "NX3224K024" ]; then
	  	sudo git clone --depth 1 https://github.com/EA7KDO/Nextion.Images /home/pi-star/Nextion_Temp
		tst=1
	fi     
	if [ "$scn" = "NX4832K035" ]; then
	  	sudo git clone --depth 1 https://github.com/EA7KDO/NX4832K035 /home/pi-star/Nextion_Temp
		tst=2
     	fi
	
	if [ "$tst" = 0 ]; then
		exitcode "Invalid EA7KDO Screen Name $scn"
	fi
}

function getve3rd
{
#	echo "Function VE3RD"
     	                if [ "$fb" ]; then
                        echo "Starting GetVe3rd Function"
                fi
	if [ "$scn" = "NX3224K024" ]; then	
	if [ -d /home/pi-star/Nextion_Temp ]; then
		rm -r /home/pi-star/Nextion_Temp
	fi
  	  sudo git clone --depth 1 https://github.com/VE3RD/Nextion /home/pi-star/Nextion_Temp 
	else
		exitcode "Invalid VE3RD Screen Name $scn"
	fi
                if [ "$fb" ]; then
                        echo "VE3RD Files git Completed"
                fi

}


if [ -z "$1" ]; then
	echo " Syntax: gitcopy.sh NX????K???   // Will copy EA7KDO Files - Default"
	echo " Syntax: gitcopy.sh NX????K??? EA7KDO // Will copy EA7KDO Files - Selected"
	echo " Syntax: gitcopy.sh NX????K??? VE3RD // Will copy VE3RD Files - Selected"
	echo " Adding a third parameter(anything) will provide feedback as the script runs (Commandline)"
	echo " " 
fi

if [ "$fb" ]; then
	if [ "$calls" == "EA7KDO" ]; then
	 	echo "Loading EA7KDO $scn Screen Package"
	fi
	if [ "$calls" == "VE3RD" ]; then
                if [ ! "$scn" = "NX3224K024" ]; then
			echo "Loading VE3RD $scn Screen Package"
		fi	
	fi
fi

if [ "$call" = "VE3RD" ]; then
     	if [ "$scn" != "NX3224K024" ]; then
		if [ "$fb" ]; then
			scn="NX3224K024"
			echo "VE3RD Screen Name MUST be NX3224K024"
			echo "Revising Screen Name to Match VE3RD Screens"
		fi
	fi
fi

sudo mount -o remount,rw /
echo "Screen $scn for $calls" > /home/pi-star/GitCopyLog.txt
#Start Duration Timer
start=$(date +%s.%N)

#Disable all command feedback
if [ ! "$fb" ]; then
	exec 3>&2
	exec 2> /dev/null 
fi

model="$scn"
tft='.tft' 
gz='.gz'

#Put Pi-Star file system in RW mode

sleep 1s

#Stop the cron service
sudo systemctl stop cron.service  > /dev/null

# Using /home/pi-star/Nextion_Temp/


#Test for /home/pi-star/Nextion_Temp and remove it, if it exists

if [ -d /home/pi-star/Nextion_Temp ]; then
  	sudo rm -R /home/pi-star/Nextion_Temp
fi

  # Get Nextion Screen/Scripts and support files from github
  # Get EA7KDO File Set

tst=0
if [ "$calls" = "EA7KDO" ]; then
	getea7kdo
 
fi


  # Get VE3RD File Set
if [ "$calls" = "VE3RD" ]; then
	getve3rd
fi

if [ -d /usr/local/etc/Nextion_Support ]; then
	sudo rm -r /usr/local/etc/Nextion_Support
                if [ "$fb" ]; then
                        echo "Removing Nextion_Support Directory"
                fi
	
fi

sudo mkdir /usr/local/etc/Nextion_Support
                if [ "$fb" ]; then
                        echo "Creating Nextion_Support Directory"
                fi

if [ "$fb" ]; then
    echo "Remove Existing $model$tft"
fi

if [ -f /usr/local/etc/"$model$tft" ]; then
	sudo rm /usr/local/etc/"$model$tft"
fi

if [ "$calls" == "EA7KDO" ]; then
	sudo chmod +x /home/pi-star/Nextion_Temp/*.sh
	sudo rsync -avqru /home/pi-star/Nextion_Temp/* /usr/local/etc/Nextion_Support/ --exclude=NX* --exclude=profiles.txt
	sudo cp /home/pi-star/Nextion_Temp/"$model$tft" /usr/local/etc/
                if [ "$fb" ]; then
                        echo "New $model$tft Copied to /usr/local/etc/"
                fi
	
fi
if [ "$calls" == "VE3RD" ]; then
	sudo chmod +x /home/pi-star/Nextion/*.sh
	sudo rsync -avqru /home/pi-star/Nextion/* /usr/local/etc/Nextion_Support/ --exclude=NX* --exclude=profiles.txt
	if [ -f /home/pi-star/Nextion/profiles.txt ]; then
		if [ ! -f /usr/local/etc/Nextion_Support/profiles.txt ]; then
        		if [ "$fb" ]; then
                		echo "Replacing Missing Profiles.txt"
        		fi
        		sudo cp  /home/pi-star/Nextion/profiles.txt /usr/local/etc/Nextion_Support/
		fi
		
		sudo cp /home/pi-star/Nextion/"$model$tft" /usr/local/etc/
                	
		if [ "$fb" ]; then
                        echo "New $model$tft Copied to /usr/local/etc/"
                fi

	fi
	
fi

 FILE=/usr/local/etc/"$model$tft"
 if [ ! -f "$FILE" ]; then
        # Copy failed
      echo "No TFT File Available to Flash - Try Again"
	exitcode
 fi

sudo systemctl start cron.service  > /dev/null

duration=$(echo "$(date +%s.%N) - $start" | bc)
execution_time=`printf "%.2f seconds" $duration`

if [ ! "$fb" ]; then
 exec 2>&3
fi 

echo "$scn Loaded: $execution_time"




