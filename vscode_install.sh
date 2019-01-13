#!/bin/sh

RASPI_IP=$(nmap -sP 192.168.100.0/24 | grep raspb | grep -o '[0-9.]\+[0-9]')

sudo rm -rf /opt/vscode
wget https://go.microsoft.com/fwlink/?LinkID=620884 -O code-stable-1570750623.tar.gz
scp pi@${RASPI_IP}:/home/pi/downloads/code-stable-1570750623.tar.gz .
sudo tar -xvf code-stable-1570750623.tar.gz -C /opt
sudo mv /opt/VSCode-linux-x64 /opt/vscode

# if [ "$OS" = "CentOS Linux" ]; then
#   wget https://go.microsoft.com/fwlink/?LinkID=760867 -O code-1.36.1-1562627663.el7.x86_64.rpm
#   sudo yum localinstall -y code-1.36.1-1562627663.el7.x86_64.rpm
# elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) ]; then
#   wget https://go.microsoft.com/fwlink/?LinkID=760868 -O code_1.36.1-1562627527_amd64.deb
#   sudo dpkg -i code_1.36.1-1562627527_amd64.deb
# else
#   echo $OS is not yet implemented.
#   exit 1
# fi

exit 0
