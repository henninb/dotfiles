#!/usr/bin/env sh

DEBIAN_FRONTEND=noninteractive

ARCHLINUX_PKGS="xorg-server vlc firefox riot-desktop i3-wm handbrake dolphin-emu dbeaver terminator handbrake rofi feh dolphin-emu xorg xorg-server xorg-xeyes xorg-xinit seahorse termite rxvt-unicode gqrx gitk"
MINT_PKGS="vlc firefox riot-desktop i3-wm handbrake dolphin-emu vim-gtk3 i3status i3blocks i3 xterm i3lock rofi terminator feh dolphin suckless-tools qt5ct gnome-boxes cockpit seahorse mplayer audacious rxvt gitk"
CENTOS_PKGS="vlc firefox riot-desktop handbrake dolphin-emu gvim terminator feh dolphin suckless-tools qt5ct gnome-boxes cockpit seahorse mplayer audacious rxvt"
UBUNTU_PKGS="vlc firefox riot-desktop handbrake dolphin-emu vim-gtk3 terminator feh dolphin suckless-tools qt5ct gnome-boxes cockpit seahorse mplayer audacious rxvt gitk"
FREEBSD_PKGS="vlc firefox riot-desktop i3-wm handbrake dolphin-emu vim-gtk3 i3status i3blocks i3 xterm i3lock rofi terminator feh dolphin suckless-tools qt5ct"
GENTOO_PKGS="vlc i3 handbrake terminator rofi games-emulation/dolphin firefox seahorse xeyes xterm i3status"

if [ "$OS" = "Arch Linux" ]; then
  FAILURES=""
  for i in $(echo $ARCHLINUX_PKGS); do
    sudo pacman --noconfirm --needed -S $i
    if [ 0 -ne $? ]; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo failures $FAILURE
elif [ "$OS" = "Gentoo" ]; then
  FAILURES=""
  for i in $(echo $GENTOO_PKGS); do
    echo sudo emerge -uf $i
    sudo emerge -uf $i
  done
  for i in $(echo $GENTOO_PKGS); do
    sudo emerge --update --newuse $i
    if [ 0 -ne $? ]; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo Failures: $FAILURE
elif [ "$OS" = "Linux Mint" ]; then
  wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo apt-key add -
  echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
  sudo apt update
  sudo apt install -y dbeaver-ce
  FAILURES=""
  for i in $(echo $MINT_PKGS); do
    sudo apt install -y $i
    if [ 0 -ne $? ]; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo failures $FAILURE
elif [ "$OS" = "CentOS Linux" ]; then
  FAILURES=""
  for i in $(echo $CENTOS_PKGS); do
    sudo yum install -y $i
    if [ 0 -ne $? ]; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo failures $FAILURE
elif [ "$OS" = "Linux Mint" ]; then
  FAILURES=""
  for i in $(echo $UBUNTU_PKGS); do
    sudo apt install -y $i
    if [ 0 -ne $? ]; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo failures $FAILURE
elif [ "$OS" = "FreeBSD" ]; then
  FAILURES=""
  for i in $(echo $UBUNTU_PKGS); do
    sudo pkg install -y $i
    if [ 0 -ne $? ]; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo failures $FAILURE
else
  echo "$OS not configured."
  exit 1
fi

exit 0
