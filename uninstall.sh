#!/bin/bash

#Request sudo permissions
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

#Remove supervisord configuration
rm ${HOME}/.config/supervisord.conf

#Remove C9 runner
rm ${HOME}/workspace/.c9/runners/c9vnc.run

#Remove noVNC
sudo rm -rf /opt/noVNC/

#Remove script directory
sudo rm -rf /opt/c9vnc/