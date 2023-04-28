#!/bin/sh

# hdhomerun_config_gui_20210624.tgz
date=20210624

cd "$HOME/projects" || exit
wget "http://download.silicondust.com/hdhomerun/libhdhomerun_${date}.tgz" -O libhdhomerun.tar.gz
wget "http://download.silicondust.com/hdhomerun/hdhomerun_config_gui_${date}.tgz" -O hdhomerun_config_gui.tar.gz

tar xvf libhdhomerun.tar.gz
tar xvf hdhomerun_config_gui.tar.gz

cd libhdhomerun || exit
make
mv -v hdhomerun_config "$HOME/.local/bin/hdhomerun_config"
mv -v libhdhomerun.so "$HOME/.local/bin/libhdhomerun.so"
cd - || exit


cd hdhomerun_config_gui || exit
./configure
make
sudo make install
mv -v src/hdhomerun_config_gui "$HOME/.local/bin/hdhomerun_config_gui"

# sudo dnf install -y hdhomerun
echo hdhomerun_config 101AE8FC save /tuner0 file.ts
echo export LD_LIBRARY_PATH=/usr/local/lib

exit 0

# vim: set ft=sh:
