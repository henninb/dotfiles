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
  sudo pacman --noconfirm --needed -S make luajit luarocks cmake base-devel lua51-lpeg lua51-mpack tree-sitter msgpack-c libluv unibilium libtermkey libvterm gperf
  sudo luarocks build mpack
  sudo luarocks build lpeg
  sudo luarocks build inspect
elif [ "$OS" = "Darwin" ]; then
  echo darwin
  brew install python3
  brew install python
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y gperf luajit luarocks libuv1-dev libluajit-5.1-dev libunibilium-dev libmsgpack-dev libtermkey-dev libvterm-dev cmake libtool-bin gettext
  sudo apt install -y g++
  sudo apt remove -y neovim
elif [ "$OS" = "Clear Linux OS" ]; then
  echo
elif [ "$OS" = "Solus" ]; then
  sudo eopkg install -c system.devel
    # sudo eopkg it -c system.devel
  sudo eopkg install -y make
  sudo eopkg install -y cmake
  sudo eopkg install -y libtool
  sudo eopkg install -y patch
  sudo eopkg install -y gcc
  sudo eopkg install -y gcc-c++
  sudo eopkg install -y pkg-config
  sudo eopkg install -y m4
  sudo eopkg install -y automake
  sudo eopkg install -y gettext
  sudo eopkg install -y gperf
  sudo eopkg install -y luajit
  sudo eopkg install -y python3-pip
  sudo eopkg install -y python3-devel
  sudo eopkg install -y python-pip
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y make
  sudo zypper install -y cmake
  sudo zypper install -y libtool
  sudo zypper install -y patch
  sudo zypper install -y gcc
  sudo zypper install -y gcc-c++
  sudo zypper install -y pkg-config
  sudo zypper install -y m4
  sudo zypper install -y automake
  sudo zypper install -y gettext
  sudo zypper install -y gperf
  sudo zypper install -y luajit
  sudo zypper install -y gettext-tools
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y make
  sudo xbps-install -y cmake
  sudo xbps-install -y libtool
  sudo xbps-install -y patch
  sudo xbps-install -y gcc
  sudo xbps-install -y gcc-c++
  sudo xbps-install -y pkg-config
  sudo xbps-install -y m4
  sudo xbps-install -y automake
  sudo xbps-install -y gettext
  sudo xbps-install -y gperf
  sudo xbps-install -y luajit
  sudo xbps-install -y python3-pip
  sudo xbps-install -y python3-devel
  sudo xbps-install -y python-pip
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y py27-pip
  sudo pkg install -y py37-pip
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y make
  sudo dnf install -y cmake
  sudo dnf install -y libtool
  sudo dnf install -y patch
  sudo dnf install -y gcc-c++
  sudo dnf install -y nodejs
elif [ "$OS" = "CentOS Linux" ]; then
  if [ "$OS_VER" = "8" ]; then
    echo centos8
    #sudo dnf remove -y neovim
    sudo dnf install -y epel-release
    sudo dnf install -y make
    sudo dnf install -y cmake
    sudo dnf install -y libtool
    sudo dnf install -y patch
    sudo dnf install -y gcc-c++
  else
    echo centos7
    sudo yum remove -y neovim
    sudo yum install -y epel-release
    sudo yum install -y libtool luajit luarocks
    sudo yum install -y make
    sudo yum install -y cmake
    sudo yum install -y libtool
    sudo yum install -y patch
    sudo yum install -y gcc-c++
  fi
elif [ "$OS" = "Gentoo" ]; then
  echo gentoo
  sudo emerge --update --newuse cmake
  sudo emerge --update --newuse luajit
  sudo luarocks build mpack
  sudo luarocks build lpeg
  sudo luarocks build inspect
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
sudo make distclean
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
sudo make distclean
cd "$HOME" || exit

#echo nvim -u NORC file
#echo "previous $ACTUAL_VER"
curl -s -O https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
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
