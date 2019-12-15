#!/bin/sh

RASPI_IP=$(nmap -sP 192.168.100.0/24 | grep raspb | grep -o '[0-9.]\+[0-9]')

sudo rm -rf /opt/vscode
wget https://go.microsoft.com/fwlink/?LinkID=620884 -O code-stable-latest.tar.gz
scp pi@${RASPI_IP}:/home/pi/downloads/code-stable-latest.tar.gz .
sudo tar -xvf code-stable-latest.tar.gz -C /opt
sudo mv /opt/VSCode-linux-x64 /opt/vscode

# if [ "$OS" = "CentOS Linux" ]; then
#   echo
# elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) ]; then
#   echo
# else
#   echo $OS is not yet implemented.
#   exit 1
# fi

exit 0
