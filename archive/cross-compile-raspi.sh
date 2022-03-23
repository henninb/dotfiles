#!/bin/sh

sudo apt install -y cmake ia32-libs
git clone git://github.com/raspberrypi/tools.git


echo https://blog.kitware.com/cross-compiling-for-raspberry-pi/

mkdir -p  ~/src/RaspberryPi/toolchain
mkdir -p ~/local/crosstool-ng

sudo apt install -y bison cvs flex gperf texinfo automake libtool help2man
wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.24.0.tar.xz
tar xvf crosstool-ng-1.24.0.tar.xz
cd crosstool-ng-1.24.0 || exit
./configure --prefix="$HOME/.local"
make
make install

exit 0
