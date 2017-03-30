#!/bin/bash

function showHelp {
    echo -e "Usage: c9vnc <args>"
    echo -e "   -h          Print this message"
    echo -e "   -f          Run in the foreground"
    echo -e "   -k          Kill running daemon"
    echo -e "No arguments will try to start daemon process"
}

function runningMessage {
    echo VNC client running at https://$C9_HOSTNAME/vnc.html
}

function foregroundStart {

    #Run C9vnc in foreground
    
    #Back up existing conf
    cp ${HOME}/.config/supervisord.conf ${HOME}/.config/supervisord.conf.bak
    #Modify supervisord.conf
    sed -i -e 's/nodaemon=false/nodaemon=true/' ${HOME}/.config/supervisord.conf
    
    #Run supervisord
    supervisord -c ${HOME}/.config/supervisord.conf
    
    #Revert back to original
    mv ${HOME}/.config/supervisord.conf.bak ${HOME}/.config/supervisord.conf
}

function daemonStart {
    echo -e "Starting c9vnc daemon"
    
    #Run supervisord
    supervisord -c ${HOME}/.config/supervisord.conf
}

function daemonStop {
    #Stop all C9vnc sub-processes
    supervisorctl stop novnc
    supervisorctl stop fluxbox
    supervisorctl stop x11vnc
    supervisorctl stop xvfb
}

# No arguments, default to starting the daemon
if [ $# -eq 0 ]
  then
    runningMessage; daemonStart ; read -n 1 -s ; exit ;
fi

while getopts :hfk opt; do
    case $opt in 
        h) showHelp; exit ;;
        f) runningMessage; foregroundStart ;;
        k) daemonStop ; exit ;;
       \?) echo "Unknown option -$OPTARG"; exit 1;;
    esac
done