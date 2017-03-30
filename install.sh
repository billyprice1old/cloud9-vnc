#!/bin/bash

#Request sudo permissions
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

#Get prerequisites
sudo apt-get install supervisor xvfb fluxbox x11vnc websockify

#Clone noVNC into proper /opt/ directory
git clone git://github.com/kanaka/noVNC /opt/noVNC/

#Copy supervisord configuration to proper configuration directory
cp supervisord.conf ${HOME}/.config/supervisord.conf

#Create the proper directory for the script
sudo mkdir -p /opt/c9vnc

#Make sure that the runners folder exists
mkdir -p ${HOME}/workspace/.c9/runners

#Copy the C9 runner to the C9 watch folder
cp c9vnc.run ${HOME}/workspace/.c9/runners/c9vnc.run

#Copy the run script to proper /opt/ directory
sudo cp run.sh /opt/c9vnc/c9vnc.sh

#Copy the run script to proper /opt/ directory
sudo cp uninstall.sh /opt/c9vnc/uninstall.sh

#Set up password for x11vnc
#Sets password from ~/.vnc/passwd
#When running x11vnc, do x11vnc -usepw
echo
echo
while true; do
    read -p "Do you wish to set password for x11vnc? (not recommended for public workspaces!) " yn
    case $yn in
        [Yy]* ) stty -echo; printf "Enter a password: "; read PASSWORD; stty echo; printf "\n"; mkdir -p ~/.vnc/ ; echo "$PASSWORD"|tr -d '\n' > ~/.vnc/passwd ; sed -i -e 's/x11vnc/x11vnc -usepw/g' ${HOME}/.config/supervisord.conf ; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo
echo

#Export X11 Settings
mkdir -p /tmp/X11
export XDG_RUNTIME_DIR=/tmp/X11
export DISPLAY=:99.0

echo export XDG_RUNTIME_DIR=/tmp/X11 >> ~/.bashrc
echo export DISPLAY=:99.0 >> ~/.bashrc