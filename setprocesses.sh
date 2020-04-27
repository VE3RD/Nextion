#!/bin/bash
############################################################
#  Set or Enable DMR in MMDVMHost                          #
#  VE3RD                                      2020-04-24   #
############################################################
set -o errexit
set -o pipefail
if [ -z "$1" ]; then
exit

fi
sudo mount -o remount,rw /


function StopServices
{
	sudo systemctl stop mmdvmhost.timer
	if [ "$?" = 1 ]; then
		echo  "mmdvmhost.timer failed to stop" >> /home/pi-star/ActivateProfile.txt
	fi
#	sudo pistar-watchdog.service stop
	sudo systemctl stop pistar-watchdog.service > /dev/null
	if [ "$?" = 1 ]; then
		echo  "pistar-watchdog  failed to stop" >> /home/pi-star/ActivateProfile.txt
	fi
#	sudo mmdvmhost.service stop
	sudo systemctl stop mmdvmhost.service
	if [ "$?" = 1 ]; then
		echo  "mmdvmhost.service  failed to stop" >> /home/pi-star/ActivateProfile.txt
	fi
	sudo systemctl stop cron.service
	if [ "$?" = 1 ]; then
		echo  "cron service failed to stop" >> /home/pi-star/ActivateProfile.txt
	fi
echo "Processes Stopped"
}

function StartServices
{
#	sudo pistar-watchdog.service start
	sudo systemctl start pistar-watchdog.service
	if [ "$?" = 1 ]; then
		echo  "pistar-watchdog  failed to start" >> /home/pi-star/ActivateProfile.txt
	fi
#	sudo mmdvmhost.service start
	sudo systemctl stop mmdvmhost.service
	if [ "$?" = 1 ]; then
		echo  "mmdvmhost.service  failed to start" >> /home/pi-star/ActivateProfile.txt
	fi
	sudo systemctl start mmdvmhost.timer
	if [ "$?" = 1 ]; then
		echo  "mmdvmhost.timer failed to start" >> /home/pi-star/ActivateProfile.txt
	fi
	sudo systemctl start cron.service
	if [ "$?" = 1 ]; then
		echo  "cron service failed to start" >> /home/pi-star/ActivateProfile.txt
	fi
echo "Processes Started"

}

if [ "$1" = "0" ]; then
StopServices
fi
if [ "$1" = "1" ]; then
StartServices
fi
echo "Script Terminated without Error"
