#!/bin/bash

# Install prerequisites (supervisor xvfb fluxbox x11vnc websockify)
# Redirect stdout to null
install_prerequisites() {
    sudo apt-get update
    sudo apt-get install -y supervisor xvfb fluxbox x11vnc websockify
}


#Request sudo permissions
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

# Check prerequisites

declare -a NEEDED_SOFTWARE_LIST=(supervisord xvfb-run fluxbox x11vnc websockify)
for SOFTWARE in ${NEEDED_SOFTWARE_LIST[@]} ; do
    
    $SOFTWARE --version |& grep "command not found" && (
        read -p "Missing $SOFTWARE, do you want to install it? [Y/n] " yn
        case $yn in
            [Yy]* ) install_prerequisites; break;;
            [Nn]* ) break;;
            * ) install_prerequisites;;
        esac
        break;
      );
done

#Clone noVNC into proper /opt/ directory
echo "Cloning noVNC..."
echo

{
    git clone git://github.com/kanaka/noVNC /opt/noVNC/
}&> /dev/null

#Copy supervisord configuration to proper configuration directory
echo "Configuring supervisord..."
echo

cp supervisord.conf ${HOME}/.config/supervisord.conf

#Make sure that the runners folder exists
echo "Installing C9 runner..."
echo

mkdir -p ${HOME}/workspace/.c9/runners

#Copy the C9 runner to the C9 watch folder
\cp c9vnc.run ${HOME}/workspace/.c9/runners/c9vnc.run

#Create the proper directory for the script
echo "Install run script..."
echo

sudo mkdir -p /opt/c9vnc

#Copy the run script to proper /opt/ directory
sudo \cp run.sh /opt/c9vnc/c9vnc.sh

#Copy the uninstall script to proper /opt/ directory
sudo \cp uninstall.sh /opt/c9vnc/uninstall.sh

#Symlink script
{
    ln -s /opt/c9vnc/c9vnc.sh /usr/local/bin/c9vnc
}&> /dev/null

#Export X11 Settings
echo "Configuring X11"
echo

mkdir -p /tmp/X11
echo export XDG_RUNTIME_DIR=/tmp/C9VNC >> ~/.bashrc
echo export DISPLAY=:99.0 >> ~/.bashrc
source ~/.bashrc

#Set up password for x11vnc
#Sets password from ~/.vnc/passwd
#When running x11vnc, do x11vnc -usepw
    # Hacky security flaw where I allow read access to ~/.vnc/passwd to group and other
    # This is done so you don't have to run x11vnc as root (which causes all sorts of trouble)
while true; do
    read -p "Do you wish to set password for x11vnc? (not recommended for public workspaces!) " yn
    case $yn in
        [Yy]* ) sudo x11vnc -storepasswd ; sed -i -e 's/command=x11vnc/command=x11vnc -usepw/g' ${HOME}/.config/supervisord.conf ; sudo chmod go+r ~/.vnc/passwd ; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
