#!/bin/sh

mkdir -p $HOME/.urxvt/perl-extensions

if [ "$OS" = "Gentoo" ]; then
  echo sudo emerge --update --newuse rxvt-unicode
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt update
  sudo apt upgrade -y
  #sudo apt install -y rxvt-unicode xsel
elif [ "$OS" = "Ubuntu" ]; then
  sudo apt update
  sudo apt upgrade -y
  #sudo apt install -y rxvt-unicode xsel
elif [ "$OS" = "Fedora" ]; then
  #sudo dnf install rxvt-unicode
  sudo dnf install fontawesome-fonts
  echo add libs
elif [ "$OS" = "Linux Mint" ]; then
  sudo apt update
  sudo apt upgrade -y
  #sudo apt install -y rxvt-unicode xsel
elif [ "$OS" = "Arch Linux" ]; then
  # urxvt needs to be installed from the package
  sudo pacman -S --noconfirm --needed rxvt-unicode xsel
  exit 0
  s#udo pacman -S awesome-terminal-fonts
else
  echo $OS is not yet implemented.
  exit 1
fi

cd $HOME/projects
wget http://dist.schmorp.de/rxvt-unicode/Attic/rxvt-unicode-9.22.tar.bz2
if [ $? -ne 0 ]; then
  echo "wget failed."
  exit 1
fi
tar xvf rxvt-unicode-9.22.tar.bz2
if [ $? -ne 0 ]; then
  echo "tar failed."
  exit 1
fi
cd rxvt-unicode-9.22
./autogen.sh
if [ $? -ne 0 ]; then
  echo "autogen failed."
  exit 1
fi
./configure --enable-everything --disable-perl --enable-smart-resize --enable-256-color
if [ $? -ne 0 ]; then
  echo "configure failed."
  exit 1
fi
make
if [ $? -ne 0 ]; then
  echo "make failed."
  exit 1
fi
sudo make install
cd $HOME

echo fc-match Monospace
fc-match Monospace

#wget https://github.com/exg/rxvt-unicode/archive/rxvt-unicode-rel-9.22.tar.gz

echo xrdb ~/.Xresources
echo xrdb -merge ~/.Xresources

echo urxvt -fn "xft:Bitstream Vera Sans Mono:pixelsize=15"
echo urxvt -fn "xft:FontAwesome:pixelsize=15"
echo urxvt --font "xft:Inconsolata for Powerline:size=10"
echo urxvt --font "xft:DejaVu Sans Mono for Powerline:size 16"
echo urxvt -fn "xft:Source Code Pro:size=10,xft:Source Han Sans,xft:DejaVu Serif:size=9"
echo urxvt -font "xft:Deja Vu Sans Mono:size=12"
echo urxvt -font "xft:SauceCodePro NF:pixelsize=9"

fc-match FontAwesome
fc-match 'Courier New:slant=0:weight=100:pixelsize=24:antialias=False:autohint=True:minspace=True'
echo cat /etc/default/locale

echo sudo locale-gen en_US.UTF-8
echo locale -a
echo update-locale LANG=en_US.UTF-8
echo https://github.com/ryanoasis/nerd-fonts

exit 0

