#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi


sudo apt-get install supervisor xvfb fluxbox x11vnc

cp supervisord.conf ${HOME}/.config/supervisord.conf

sudo mkdir /opt/c9vnc
mkdir ${HOME}/workspace/.c9/runners

cp c9vnc.run ${HOME}/workspace/.c9/runners/c9vnc.run
cp run.sh /opt/c9vnc/run.sh

git clone git://github.com/kanaka/noVNC /opt/noVNC/

