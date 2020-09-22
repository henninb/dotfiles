#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y make
  sudo apt install -y gtk-doc
  sudo apt install -y intltool
  sudo apt install -y gnutls-devel
  sudo apt install -y gperf
  sudo apt install -y pkg-config
  sudo apt install -y gtk-doc-tools
  sudo apt install -y g++
  sudo apt install -y gnutls-dev
  sudo apt install -y libpcre2-dev
  sudo apt install -y intltool
  #sudo apt install -y gtk3-devel
  sudo apt install -y libgtk-3-dev
  sudo apt install -y libgtk2.0-dev
  #sudo apt install gnome-devel
  sudo apt install -y gtk+3.0
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y gtk-doc
  sudo apt install -y g++
  sudo pkg install -y autoconf
  sudo pkg install -y autotools
  sudo pkg install -y autogen
elif [ "$OS" = "Solus" ]; then
  sudo eopkg install -y gtk-doc
  sudo eopkg install -y libgnutls-devel
  sudo eopkg install -y pango-devel
  sudo eopkg install -y libgtk-3-devel
  sudo eopkg install -y pcre2-devel
elif [ "$OS" = "Gentoo" ]; then
  echo gentoo
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman -Rsn termite
  sudo pacman -S gtk-doc
  sudo pacman -S intltool
  sudo pacman -S gperf
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install -y gtk-doc
  sudo dnf install -y intltool
  sudo dnf install -y gtk3-devel
  sudo dnf install -y gnutls-devel
  sudo dnf install -y gperf
else
  echo "$OS is not yet implemented."
  exit 1
fi

mkdir -p "$HOME/projects"
cd "$HOME/projects" || exit
git clone --recursive git@github.com:thestinger/termite.git
git clone git@github.com:thestinger/vte-ng.git

cd "$HOME/projects/vte-ng" || exit
if ! ./autogen.sh --disable-introspection --disable-vala; then
  echo failed autogen
  exit 1
fi

if ! make; then
  echo failed make
  exit 1
fi

if ! sudo make install; then
  echo failed install
  exit 1
fi

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig
cd "$HOME/projects/termite" || exit
if ! make; then
  echo failed make
  exit 1
fi

if ! sudo make install; then
  echo failed install
  exit 1
fi

sudo touch /etc/ld.so.conf.d/vte.conf
sudo ldconfig

exit 0
