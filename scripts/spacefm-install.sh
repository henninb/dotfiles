#!/bin/sh

if [ "$OS" = "Solus" ]; then
  doas eopkg install -y libgtk-2-devel
  doas eopkg install -y libgtk-3-devel
  doas eopkg install -y ffmpegthumbnailer-devel
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y libgtk2.0-dev
  doas apt install -y libgtk-3-dev
  doas apt install -y udevil
  doas apt install -y libudev-dev
  doas apt install -y libffmpegthumbnailer-dev
  doas apt install -y intltool
  doas apt install -y libtool
  doas apt install -y libtool-bin
  doas apt install -y libgtk2.0-dev
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "archlinux"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y gtk3-devel
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse x11-libs/gtk+:2
  sudo emerge --update --newuse x11-libs/gtk+:3
  doas emerge  --update --newuse ffmpegthumbnailer
elif [ "$OS" = "Fedora Linux" ]; then
  doas dnf install -y systemd-devel
  doas dnf install -y ffmpegthumbnailer-devel
elif [ "$OS" = "FreeBSD" ]; then
  doas pkg install ffmpegthumbnailer
  doas pkg install intltool
elif [ "$OS" = "Darwin" ]; then
  echo "macos"
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y spacefm
  doas xbps-install -y patch
  doas xbps-install -y intltool
  doas xbps-install -y glib-devel
  doas xbps-install -Sy ffmpegthumbnailer
  doas xbps-install -y ffmpegthumbnailer-devel
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
