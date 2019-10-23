#!/bin/bash
############################################################
#  Clear Modes in /etc/mmdvmhost                           #
#  Also disable corresponding network                       #
#  KF6S                                        09-14-2019  #
############################################################
set -o errexit
set -o pipefail
# Clear all six modes and set each one to either 0 or 1

        sudo sed -i '/\[D-Star\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
        sudo sed -i '/\[D-Star Network\]/!b;n;cEnable='"0"'' /etc/mmdvmhost

# Turn on DMR Default
        sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
	sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost

        sudo sed -i '/\[System Fusion\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
	sudo sed -i '/\[System Fusion Network\]/!b;n;cEnable='"0"'' /etc/mmdvmhost

        sudo sed -i '/\[P25\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
	sudo sed -i '/\[P25 Network\]/!b;n;cEnable='"0"'' /etc/mmdvmhost

        sudo sed -i '/\[NXDN\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
	sudo sed -i '/\[NXDN Network\]/!b;n;cEnable='"0"'' /etc/mmdvmhost

        sudo sed -i '/\[POCSAG\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
	sudo sed -i '/\[POCSAG Network\]/!b;n;cEnable='"0"'' /etc/mmdvmhost

        sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/dmr2ysf
        sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/dmr2nxdn
        sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2dmr
        sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2nxdn
        sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2p25

