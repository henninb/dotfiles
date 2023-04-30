#!/bin/sh

echo "Install the nvidia driver prior, press enter to continue"
read -r continued
echo "$continued"

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S ninja
  doas pacman --noconfirm --needed -S meson
  doas pacman --noconfirm --needed -S uthash
  doas pacman --noconfirm --needed -S cmake
  doas pacman --noconfirm --needed -S libev
  doas pacman --noconfirm --needed -S libconfig
elif [ "$OS" = "FreeBSD" ]; then
  doas pkg install -y ninja
  doas pkg install -y meson
  doas pkg install -y uthash
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y uthash-dev libxcb-sync-dev libxcb-present-dev libxcb-damage0-dev libconfig-dev libdbus-1-dev
  doas apt install -y libx11-xcb-dev
  doas apt install -y libev-dev
  # sudo apt install -y libpcre2-dev
  doas apt install -y libpcre3-dev
  # sudo apt install -y libpcre2
  doas apt install -y libpixman-1-dev
  doas apt install -y libxcb-render-util0-dev
  doas apt install -y libxcb-image0-dev
  doas apt install -y libxcb-composite0-dev
  doas apt install -y libxcb-xinerama0-dev
  doas apt install -y libglew-dev
  doas apt isntall -y menson
  doas apt isntall -y ninja
  # sudo python3 -m pip install ninja
  # sudo python3 -m pip install meson
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y cmake
  doas zypper install -y xcb-util-renderutil-devel
  doas zypper install -y xcb-util-image-devel
  doas zypper install -y meson
  doas zypper install -y ninja
  doas zypper install -y pcre-devel
  doas zypper install -y uthash-devel
  doas zypper install -y libev-devel
  doas zypper install -y libconfig-devel
  doas zypper install -y dbus-1-devel
  doas zypper install -y libpixman-1-0-devel
  doas zypper install -y libGLw-devel
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y ninja
  doas xbps-install -y meson
  doas xbps-install -y libev-devel
  doas xbps-install -y uthash
  doas xbps-install -y cmake
  doas xbps-install -y pcre-devel
  doas xbps-install -y libconfig-devel
  doas xbps-install -y xcb-util-renderutil-devel
  doas xbps-install -y xcb-util-image-devel
  doas xbps-install -y xcb-util-composite-devel
elif [ "$OS" = "Fedora Linux" ]; then
  doas dnf install -y ninja
  doas dnf install -y meson
  doas dnf install -y libev-devel
  doas dnf install -y uthash
  doas dnf install -y libconfig-devel
  doas dnf install -y xcb-util-renderutil-devel
  doas dnf install -y xcb-util-image-devel
  doas dnf install -y xcb-util-composite-devel
  doas dnf install -y pcre-devel
elif [ "$OS" = "Gentoo" ]; then
  if ! command -v ninja; then
    sudo emerge --update --newuse dev-util/ninja
  fi
  doas emerge --update --newuse uthash
  doas emerge --update --newuse libconfig
else
  echo "OS=$OS not setup yet."
  exit 1
fi

mkdir -p "$HOME/projects/github.com/jonaburg"
cd "$HOME/projects/github.com/jonaburg" || exit
git clone https://github.com/jonaburg/picom
cd ./picom || exit
meson --buildtype=release . build
ninja -C build
# To install the binaries in /usr/local/bin (optional)
doas ninja -C build install

exit 0

# vim: set ft=sh:
