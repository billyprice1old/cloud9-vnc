#!/bin/bash

#Request sudo permissions
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

# Kill running sessions
echo "Killing running sessions"
echo
/opt/c9vnc/c9vnc.sh -k

#Remove supervisord configuration
echo "Removing supervisord configuration"
echo
rm -f ${HOME}/.config/supervisord.conf

#Remove C9 runner
echo "Removing C9 runner"
echo
rm -f ${HOME}/workspace/.c9/runners/c9vnc.run

#Remove noVNC
echo "Removing noVNC"
echo
sudo rm -rf /opt/noVNC/

#Remove script directory
echo "Removing install directory"
echo
sudo rm -rf /opt/c9vnc/

#Remove X11 exports
echo "Removing X11 configuration"
echo
grep -v "export DISPLAY=:99.0" ~/.bashrc > /tmp/bashrc-temp
mv /tmp/bashrc-temp ~/.bashrc
grep -v "export XDG_RUNTIME_DIR=/tmp/C9VNC" ~/.bashrc > /tmp/bashrc-temp
mv /tmp/bashrc-temp ~/.bashrc
rm -f /tmp/bashrc-temp

echo "Uninstalled cloud9-vnc"