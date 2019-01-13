#!/bin/sh

sudo apt install -y libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev libjansson-dev libpython-dev make libgcrypt11-dev libssl1.0-dev
sudo pacman -S libconfig

cd projects
git clone --recursive https://github.com/vysheng/tg.git telegram-cli
cd telegram-cli
make clean
./configure
echo ./configure --disable-openssl
make

exit 0
