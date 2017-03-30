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

#Remove X11 exports
sed -i -e 's/export XDG_RUNTIME_DIR=/tmp/X11/g' ${HOME}/.bashrc
sed -i -e 's/export DISPLAY=:99.0/g' ${HOME}/.bashrc

#Remove aliases
sed -i -e 's/alias c9vnc=/opt/c9vnc/c9vnc.sh/g' ${HOME}/.bash_aliases
sed -i -e 's/alias c9vnc-uninstall=/opt/c9vnc/uninstall.sh/g' ${HOME}/.bash_aliases