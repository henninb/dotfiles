#!/bin/sh

sudo pacman --noconfirm --needed -S avr-gcc
sudo pacman --noconfirm --needed -S avrdude
sudo pacman --noconfirm --needed -S arduino-cli

sudo emerge --update --newuse avrdude
# sudo emerge --update --newuse avr-gcc
sudo emerge --update --newuse sys-devel/crossdev

sudo dnf install -y avrdude

sudo xbps-install -y avr-gcc
sudo xbps-install -y avrdude
sudo xbps-install -y arduino-cli

pip install platformio
pip install esptool

if ! command -v arduino-cli; then
  cd "$HOME/.local"
  curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
fi

arduino-cli core update-index
arduino-cli core install arduino:avr
arduino-cli core install stm32duino:STM32F1
arduino-cli core install esp32:esp32
arduino-cli core install esp8266:esp8266

exit 0
