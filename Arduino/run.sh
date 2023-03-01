#!/bin/sh

sudo pacman --noconfirm --needed -S avr-gcc
sudo pacman --noconfirm --needed -S avrdude

sudo emerge --update --newuse avrdude
# sudo emerge --update --newuse avr-gcc
sudo emerge --update --newuse sys-devel/crossdev

# curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh

exit 0
