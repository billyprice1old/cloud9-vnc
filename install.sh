#!/bin/bash

#Request sudo permissions
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

#Get prerequisites
sudo apt-get install supervisor xvfb fluxbox x11vnc

#Copy supervisord configuration to proper configuration directory
cp supervisord.conf ${HOME}/.config/supervisord.conf

#Create the proper directory for the script
sudo mkdir /opt/c9vnc

#Make sure that the runners folder exists
mkdir ${HOME}/workspace/.c9/runners

#Copy the C9 runner to the C9 watch folder
cp c9vnc.run ${HOME}/workspace/.c9/runners/c9vnc.run

#Copy the run script to proper /opt/ directory
cp run.sh /opt/c9vnc/run.sh

#Clone noVNC into proper /opt/ directory
git clone git://github.com/kanaka/noVNC /opt/noVNC/