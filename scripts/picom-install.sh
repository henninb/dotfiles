#!/bin/sh

echo "Install the nvidia driver prior, press enter to continue"
read -r continued
echo "$continued"

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S ninja
  sudo pacman --noconfirm --needed -S meson
  sudo pacman --noconfirm --needed -S uthash
  sudo pacman --noconfirm --needed -S cmake
  sudo pacman --noconfirm --needed -S libev
  sudo pacman --noconfirm --needed -S libconfig
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y ninja
  sudo pkg install -y meson
  sudo pkg install -y uthash
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y uthash-dev libxcb-sync-dev libxcb-present-dev libxcb-damage0-dev libconfig-dev libdbus-1-dev
  sudo apt install -y libx11-xcb-dev
  sudo apt install -y libev-dev
  # sudo apt install -y libpcre2-dev
  sudo apt install -y libpcre3-dev
  # sudo apt install -y libpcre2
  sudo apt install -y libpixman-1-dev
  sudo apt install -y libxcb-render-util0-dev
  sudo apt install -y libxcb-image0-dev
  sudo apt install -y libxcb-composite0-dev
  sudo apt install -y libxcb-xinerama0-dev
  sudo apt install -y libglew-dev
  sudo apt isntall -y menson
  sudo apt isntall -y ninja
  # sudo python3 -m pip install ninja
  # sudo python3 -m pip install meson
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y cmake
  sudo zypper install -y xcb-util-renderutil-devel
  sudo zypper install -y xcb-util-image-devel
  sudo zypper install -y meson
  sudo zypper install -y ninja
  sudo zypper install -y pcre-devel
  sudo zypper install -y uthash-devel
  sudo zypper install -y libev-devel
  sudo zypper install -y libconfig-devel
  sudo zypper install -y dbus-1-devel
  sudo zypper install -y libpixman-1-0-devel
  sudo zypper install -y libGLw-devel
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y ninja
  sudo xbps-install -y meson
  sudo xbps-install -y libev-devel
  sudo xbps-install -y uthash
  sudo xbps-install -y cmake
  sudo xbps-install -y pcre-devel
  sudo xbps-install -y libconfig-devel
  sudo xbps-install -y xcb-util-renderutil-devel
  sudo xbps-install -y xcb-util-image-devel
  sudo xbps-install -y xcb-util-composite-devel
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y ninja
  sudo dnf install -y meson
  sudo dnf install -y libev-devel
  sudo dnf install -y uthash
  sudo dnf install -y libconfig-devel
  sudo dnf install -y xcb-util-renderutil-devel
  sudo dnf install -y xcb-util-image-devel
  sudo dnf install -y xcb-util-composite-devel
  sudo dnf install -y pcre-devel
elif [ "$OS" = "Gentoo" ]; then
  if ! command -v ninja; then
    sudo emerge --update --newuse dev-util/ninja
  fi
  sudo emerge --update --newuse uthash
  sudo emerge --update --newuse libconfig
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
sudo ninja -C build install

exit 0

# vim: set ft=sh
