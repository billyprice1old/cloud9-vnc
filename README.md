VNC
===

Running X11 in a Cloud9 workspace.

![Screen Shot](screenshot.png)

Installation
------------


Clone the repository to where you'd like (in the example I use the home folder ~)
    
    cd ~
    git clone https://github.com/acabey/cloud9-vnc.git


Enter the repository sub-directory

    cd cloud9-vnc/

Now make sure apt-get has been updated with 

    sudo apt-get update

Run the install script with privileges

    sudo ./install.sh
    
If you would like to export a "permanent alias" to run the script, run

    echo alias c9vnc=/opt/c9vnc/c9vnc.sh >> ~/.bash_aliases
    

Running
-------

Use the custom C9 runner

    Run > Run With > C9vnc
    
Or run the script directly from the /opt/ directory

    /opt/c9vnc/c9vnc.sh
    
You can also export an alias to this script and run with the alias

    alias c9vnc=/opt/c9vnc/c9vnc.sh
    
    c9vnc
