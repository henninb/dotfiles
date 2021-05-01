#!/bin/sh

cd "$HOME/projects" || exit
git clone https://github.com/micronucleus/micronucleus
cd - || exit

# attiny85 hooked up to an arduino isp programmer
avrdude -v -P /dev/ttyUSB0 -b 19200 -c avrisp -p attiny85 -Uflash:w:micronucleus-attiny85-default.hex:i -U lfuse:w:0xe1:m -U hfuse:w:0xdd:m -U efuse:w:0xfe:m

exit 0
