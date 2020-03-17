#!/bin/sh

sudo apt install apt-transport-https curl

curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt -y update

sudo apt install -y brave-browser

yay -S brave-bin

sudo eselect repository enable brave-overlay
sudo emerge --sync
sudo emerge www-client/brave-bin-1.5.111

exit 0
