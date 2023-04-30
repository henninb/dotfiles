#!/bin/sh

if [ $# -eq 1 ]; then
  VER_OVERRIDE=$1
fi

NVER=$(curl -s https://github.com/neovim/neovim/releases/ | grep release | grep -v nightly | grep 'tar.gz' | head -1 | grep -o 'v[0-9.]\+[0-9]')
ACTUAL_VER=$(nvim --version | grep -o 'v[0-9.]\+[0-9]')

if [ "$ACTUAL_VER" = "$NVER" ]; then
  echo "already at the latest version $NVER."
fi

if  [ -n "$VER_OVERRIDE" ]; then
  NVER=${VER_OVERRIDE}
fi

export NVER=v0.8.3
echo "$NVER"

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S make luajit luarocks cmake base-devel lua51-lpeg lua51-mpack tree-sitter msgpack-c libluv unibilium libtermkey libvterm gperf
  doas luarocks build mpack
  doas luarocks build lpeg
  doas luarocks build inspect
elif [ "$OS" = "Darwin" ]; then
  echo darwin
  brew install python3
  brew install python
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y gperf luajit luarocks libuv1-dev libluajit-5.1-dev libunibilium-dev libmsgpack-dev libtermkey-dev libvterm-dev cmake libtool-bin gettext
  doas apt install -y g++
  doas apt remove -y neovim
elif [ "$OS" = "Clear Linux OS" ]; then
  echo
elif [ "$OS" = "Solus" ]; then
  doas eopkg install -c system.devel
    # sudo eopkg it -c system.devel
  doas eopkg install -y make
  doas eopkg install -y cmake
  doas eopkg install -y libtool
  doas eopkg install -y patch
  doas eopkg install -y gcc
  doas eopkg install -y gcc-c++
  doas eopkg install -y pkg-config
  doas eopkg install -y m4
  doas eopkg install -y automake
  doas eopkg install -y gettext
  doas eopkg install -y gperf
  doas eopkg install -y luajit
  doas eopkg install -y python3-pip
  doas eopkg install -y python3-devel
  doas eopkg install -y python-pip
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y make
  doas zypper install -y cmake
  doas zypper install -y libtool
  doas zypper install -y patch
  doas zypper install -y gcc
  doas zypper install -y gcc-c++
  doas zypper install -y pkg-config
  doas zypper install -y m4
  doas zypper install -y automake
  doas zypper install -y gettext
  doas zypper install -y gperf
  doas zypper install -y luajit
  doas zypper install -y gettext-tools
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y make
  doas xbps-install -y cmake
  doas xbps-install -y libtool
  doas xbps-install -y patch
  doas xbps-install -y gcc
  doas xbps-install -y gcc-c++
  doas xbps-install -y pkg-config
  doas xbps-install -y m4
  doas xbps-install -y automake
  doas xbps-install -y gettext
  doas xbps-install -y gperf
  doas xbps-install -y luajit
  doas xbps-install -y python3-pip
  doas xbps-install -y python3-devel
  doas xbps-install -y python-pip
elif [ "$OS" = "FreeBSD" ]; then
  doas pkg install -y py27-pip
  doas pkg install -y py37-pip
elif [ "$OS" = "Fedora Linux" ]; then
  doas dnf install -y make
  doas dnf install -y cmake
  doas dnf install -y libtool
  doas dnf install -y patch
  doas dnf install -y gcc-c++
  doas dnf install -y nodejs
elif [ "$OS" = "CentOS Linux" ]; then
  if [ "$OS_VER" = "8" ]; then
    echo centos8
    #sudo dnf remove -y neovim
    doas dnf install -y epel-release
    doas dnf install -y make
    doas dnf install -y cmake
    doas dnf install -y libtool
    doas dnf install -y patch
    doas dnf install -y gcc-c++
  else
    echo centos7
    doas yum remove -y neovim
    doas yum install -y epel-release
    doas yum install -y libtool luajit luarocks
    doas yum install -y make
    doas yum install -y cmake
    doas yum install -y libtool
    doas yum install -y patch
    doas yum install -y gcc-c++
  fi
elif [ "$OS" = "Gentoo" ]; then
  echo gentoo
  doas emerge --update --newuse cmake
  doas emerge --update --newuse luajit
  doas luarocks build mpack
  doas luarocks build lpeg
  doas luarocks build inspect
else
  echo "$OS is not yet implemented."
  exit 1
fi

mkdir -p "$HOME/projects/github.com/neovim"
cd "$HOME/projects/github.com/neovim" || exit
git clone --recursive git@github.com:neovim/neovim.git
cd "$HOME/projects/github.com/neovim/neovim" || exit
git checkout master
git fetch
if ! git checkout "tags/$NVER"; then
  echo "git checkout tag version $NVER failed."
  exit 1
fi
doas make distclean
sed -i 's/CONFIGURE_COMMAND ""//g' third-party/cmake/BuildLibvterm.cmake
# if ! make CMAKE_BUILD_TYPE=RelWithDebInfo; then
if ! make CMAKE_BUILD_TYPE=RelWithDebInfo; then
# if ! make CMAKE_BUILD_TYPE=RelWithDebInfo USE_BUNDLED=OFF; then
  echo make failed.
  exit 1
fi

if ! sudo make install; then
  echo make install failed.
  exit 1
fi

echo make install_local
doas make distclean
cd "$HOME" || exit

#echo nvim -u NORC file
#echo "previous $ACTUAL_VER"
curl -s -O https://bootstrap.pypa.io/get-pip.py
doas python3 get-pip.py
# sudo python2 get-pip.py

sudo mkdir -p /usr/local/share/nvim
sudo chmod -R a+r /usr/local/share/nvim
sudo chmod -R a+x /usr/local/share/nvim
python2 -m pip install --user --upgrade pynvim
python3 -m pip install --user --upgrade pynvim
pip2 uninstall neovim
pip3 uninstall neovim
pip3 install neovim-remote
gem install neovim
echo ":checkhealth"

nvim +slient +VimEnter +PlugUpgrade +qall
nvim +slient +VimEnter +PlugUpdate +qall

# gem install neovim
gem install --user neovim
npm install -g neovim

exit 0

# vim: set ft=sh:
