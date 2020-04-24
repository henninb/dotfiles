#!/bin/sh

sudo apt install -y spacefm udevil libudev-dev libffmpegthumbnailer-dev

cd "$HOME/projects"
git clone git@github.com:IgnorantGuru/spacefm.git
cd spacefm
./autogen.sh
make
sudo make install

exit 0
