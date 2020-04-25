#!/bin/sh

sudo apt install -y spacefm udevil libudev-dev libffmpegthumbnailer-dev intltool libtool
sudo apt install -y libgtk2.0-dev

# sudo apt install -y autotools-dev bash build-essential intltool pkg-config fakeroot shared-mime-info desktop-file-utils libc6 libcairo2 libglib2.0-0 libglib2.0-dev libpango1.0-0 libx11-6 libx11-dev libudev1 libudev-dev libffmpegthumbnailer-dev

cd "$HOME/projects"
git clone git@github.com:IgnorantGuru/spacefm.git
cd spacefm
./autogen.sh
make
sudo make install

exit 0
