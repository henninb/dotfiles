#!/bin/sh

sudo pacman --noconfirm --needed -S avr-gcc
sudo pacman --noconfirm --needed -S avrdude
sudo pacman --noconfirm --needed -S arduino-cli
pip install platformio
pip install esptool.py
arduino-cli core update-index
arduino-cli core install arduino:avr
arduino-cli core install stm32duino:STM32F1
arduino-cli core install esp32:esp32
arduino-cli core install esp8266:esp8266

exit 0
