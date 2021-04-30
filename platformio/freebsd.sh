#!/bin/sh


sudo pkg install -y avr-binutils
sudo pkg install -y avr-gcc
sudo pkg install -y avr-libc

cd "$HOME/projects" || exit

git clone https://github.com/trombik/freebsd-ports-xtensa-lx106-elf.git
#git clone https://github.com/trombik/platformio-freebsd-toolchain-xtensa.git

cd ~/.platformio/packages
git clone https://github.com/trombik/platformio-freebsd-toolchain-atmelavr.git toolchain-atmelavr
cd ~/.platformio/packages/toolchain-atmelavr
./init.sh
cd -

exit 0
