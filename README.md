VNC
===

Running X11 in a Cloud9 workspace.

![Screen Shot](screenshot.png)

Installation
------------

Run the install script with privileges

    sudo ./install.sh

Running
-------

Use the custom C9 runner

    Run > Run With > C9vnc
    
Or run the script directly from the /opt/ directory

    /opt/c9vnc/c9vnc.sh
    
You can also export an alias to this script and run with the alias

    alias c9vnc=/opt/c9vnc/c9vnc.sh
    
    c9vnc