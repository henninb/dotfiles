#!/bin/sh

if [ "$OS" = "Solus" ]; then
  sudo eopkg install -y libgtk-2-devel
  sudo eopkg install -y libgtk-3-devel
  sudo eopkg install -y libgtk-2-devel
  sudo eopkg install -y libgtk-3-devel
  sudo eopkg install -y ffmpegthumbnailer-devel
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y libgtk2.0-dev
  sudo apt install -y libgtk-3-dev
  sudo apt install -y udevil
  sudo apt install -y libudev-dev
  sudo apt install -y libffmpegthumbnailer-dev
  sudo apt install -y intltool
  sudo apt install -y libtool
  sudo apt install -y libtool-bin
  sudo apt install -y libgtk2.0-dev
elif [ "$OS" = "ArcoLinux" ]; then
  echo
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y gtk3-devel
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse x11-libs/gtk+:2
  sudo emerge --update --newuse x11-libs/gtk+:3
  sudo emerge  --update --newuse ffmpegthumbnailer
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install -y systemd-devel
  sudo dnf install -y ffmpegthumbnailer-devel
elif [ "$OS" = "void" ]; then
  sudo xbps-install -y intltool
  sudo xbps-install -y glib-devel
  sudo xbps-install -S ffmpegthumbnailer
  sudo xbps-install -y ffmpegthumbnailer-devel
else
  echo "$OS is not implemented."
fi

cd "$HOME/projects" || exit
git clone git@github.com:IgnorantGuru/spacefm.git
cd spacefm || exit
./autogen.sh
patch src/main.c < "$HOME/-spacefm-main-patch"
make
if ! sudo make install; then
  echo vi projects/spacefm/src/main.c
  echo "add #include <sys/sysmacros.h> to the  src/main.c"
  echo "this will fix the major/minor failure to compile"
fi

echo "sh ./ant-dracula-theme-install.sh"

exit 0
