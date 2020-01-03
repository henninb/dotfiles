#!/bin/sh

wget http://download.silicondust.com/hdhomerun/libhdhomerun_20190621.tgz
wget http://download.silicondust.com/hdhomerun/hdhomerun_config_gui_20190621.tgz

tar xvf libhdhomerun_20190621.tgz
tar xvf hdhomerun_config_gui_20190621.tgz

sudo dnf install -y hdhomerun

exit 0
