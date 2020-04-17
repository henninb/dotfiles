#!/usr/bin/env sh

DEBIAN_FRONTEND=noninteractive

ARCHLINUX_PKGS="xorg-server vlc riot-desktop i3-wm handbrake dolphin-emu dbeaver terminator handbrake rofi feh dolphin-emu xorg xorg-server xorg-xeyes xorg-xinit seahorse termite rxvt-unicode gqrx gitk audacity zathura sxiv mpv gimp brave fslint grub-customizer hardinfo ksystemlog"

MINT_PKGS="vlc riot-desktop handbrake dolphin-emu vim-gtk3 xterm rofi terminator feh dolphin suckless-tools qt5ct gnome-boxes cockpit seahorse mplayer audacious gitk audacity gqrx-sdr gimp"

CENTOS_PKGS="vlc firefox riot-desktop handbrake dolphin-emu gvim terminator feh dolphin suckless-tools qt5ct gnome-boxes cockpit seahorse mplayer audacious rxvt"

UBUNTU_PKGS="gqrx vlc firefox riot-desktop handbrake dolphin-emu vim-gtk3 terminator feh dolphin suckless-tools qt5ct gnome-boxes cockpit seahorse mplayer audacious rxvt gitk audacity gimp fslint"

FREEBSD_PKGS="vlc firefox riot-desktop i3-wm handbrake dolphin-emu vim-gtk3 i3status i3blocks i3 xterm i3lock rofi terminator feh dolphin suckless-tools qt5ct audacity"

GENTOO_PKGS="vlc i3 handbrake terminator rofi games-emulation/dolphin firefox seahorse xeyes xterm i3status audacity"

VOID_PKGS="gimp vlc handbrake terminator audacity dolphin-emu zathura dbeaver"

SOLUS_PKGS="gimp vlc handbrake terminator audacity dolphin-emu zathura dbeaver"

FEDORA_PKGS="gvim gqrx"

MACOS_PKGS="alacritty iterm2"

if [ "$OS" = "Arch Linux" ]; then
  FAILURES=""
  for i in $(echo $ARCHLINUX_PKGS); do
    if ! sudo pacman --noconfirm --needed -S "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo failures "$FAILURE"
elif [ "$OS" = "Darwin" ]; then
  brew cask install vlc
  brew cask install alacritty
  brew cask install iterm2
elif [ "$OS" = "Solus" ]; then
  echo
elif [ "$OS" = "Gentoo" ]; then
  FAILURES=""
  for i in $(echo $GENTOO_PKGS); do
    echo sudo emerge -uf "$i"
    sudo emerge -uf "$i"
  done
  for i in $(echo $GENTOO_PKGS); do
    sudo emerge --update --newuse "$i"
    if [ 0 -ne $? ]; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo Failures: $FAILURE
elif [ "$OS" = "Linux Mint" ]; then
  echo sudo apt-add-repository ppa:dolphin-emu/ppa
  wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo apt-key add -
  echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
  echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
  sudo add-apt-repository ppa:danielrichter2007/grub-customizer
  sudo apt update
  sudo apt install -y dbeaver-ce
  sudo apt install -y balena-etcher-electron
  sudo apt install -y grub-customizer
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
elif [ "$OS" = "void" ]; then
  FAILURES=""
  for i in $(echo $VOID_PKGS); do
    sudo xbps-install -y $i
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

echo "obs-studio - open broadcast software"
echo "kdenlive - video software"

#CPU-X
yay -S cpu-x
echo https://github.com/X0rg/CPU-X
#Hardinfo
echo https://github.com/lpereira/hardinfo
#Nutty
echo https://babluboy.github.io/nutty/
yay -S nutty
#Stacer
echo https://github.com/oguzhaninan/Stacer
yay -S stacer
#Ksystemlog
echo https://kde.org/applications/system/org.kde.ksystemlog

exit 0
