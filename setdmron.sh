#!/bin/bash
############################################################
#  Set or Enable DMR in MMDVMHost                          #
#  VE3RD                                      2020-04-24   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

        sudo sed -i '/^\[/h;G;/DMR]/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost

