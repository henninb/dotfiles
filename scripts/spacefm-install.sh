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
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y systemd-devel
  sudo dnf install -y ffmpegthumbnailer-devel
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install ffmpegthumbnailer
  sudo pkg install intltool
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y intltool
  sudo xbps-install -y glib-devel
  sudo xbps-install -S ffmpegthumbnailer
  sudo xbps-install -y ffmpegthumbnailer-devel
else
  echo "$OS is not implemented."
  exit 1
fi

mkdir -p "$HOME/projects/github.com/IgnorantGuru"
cd "$HOME/projects/github.com/IgnorantGuru" || exit
git clone git@github.com:IgnorantGuru/spacefm.git
cd spacefm || exit
./autogen.sh
if ! patch src/main.c < "$HOME/patches/spacefm-main-patch"; then
  echo "main patch failed."
  exit 1
fi

if ! patch -p1 -i $HOME/patches/spacefm-settings-patch; then
  echo "settings patch failed."
  exit 1
fi

if ! make; then
  echo "build failed"
  echo "add #include <sys/sysmacros.h> to the  src/main.c"
  exit 2

fi
if ! sudo make install; then
  echo vi projects/spacefm/src/main.c
  echo "add #include <sys/sysmacros.h> to the  src/main.c"
  echo "this will fix the major/minor failure to compile"
  exit 3
fi

echo "sh ./dracula-theme-install.sh"

exit 0

# vim: set ft=sh:
