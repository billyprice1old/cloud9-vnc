#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

cd ~/

sudo apt-get install supervisor xvfb fluxbox x11vnc
git clone git://github.com/kanaka/noVNC
