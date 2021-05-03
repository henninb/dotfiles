#!/bin/sh

sudo pkg install -y avr-binutils
sudo pkg install -y avr-gcc
sudo pkg install -y avr-libc
sudo pkg install -y avrdude
sudo pkg install devel/avrdude
cp /usr/local/bin/avrdude ~/.platformio/packages/tool-avrdude/avrdude_bin

echo "set platform = atmelavr@<1.12.0 in the project platformio.ini"

cd "$HOME/projects" || exit

git clone https://github.com/trombik/freebsd-ports-xtensa-lx106-elf.git
cd - || exit

#git clone https://github.com/trombik/platformio-freebsd-toolchain-xtensa.git

cd ~/.platformio/packages || exit
git clone https://github.com/trombik/platformio-freebsd-toolchain-atmelavr.git toolchain-atmelavr
cd ~/.platformio/packages/toolchain-atmelavr || exit
./init.sh
cd - || exit

exit 0
