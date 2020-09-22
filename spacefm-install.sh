#!/bin/sh

sudo apt install -y udevil
sudo apt install -y libudev-dev
sudo apt install -y libffmpegthumbnailer-dev
sudo apt install -y intltool
sudo apt install -y libtool
sudo apt install -y libtool-bin
sudo apt install -y libgtk2.0-dev

sudo dnf install -y systemd-devel
sudo dnf install -y ffmpegthumbnailer-devel

sudo xbps-install -y intltool
sudo xbps-install -y glib-devel
sudo xbps-install -S ffmpegthumbnailer
sudo xbps-install -y ffmpegthumbnailer-devel

sudo eopkg install -y libgtk-2-devel
sudo eopkg install -y libgtk-3-devel
sudo eopkg install -y ffmpegthumbnailer-devel

sudo emerge  --update --newuse ffmpegthumbnailer

cd "$HOME/projects" || exit
git clone git@github.com:IgnorantGuru/spacefm.git
cd spacefm || exit
./autogen.sh
make
if ! sudo make install; then
  echo vi projects/spacefm/src/main.c
  echo "add #include <sys/sysmacros.h> to the  src/main.c"
  echo "this will fix the major/minor failure to compile"
fi

echo "install ant-dracula-theme-install.sh"

exit 0
