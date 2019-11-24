#!/bin/sh

NVER=$(curl https://github.com/neovim/neovim/releases/ | grep release | grep -v nightly | grep 'tar.gz' | head -1 | grep -o 'v[0-9.]\+[0-9]')
ACTUAL_VER=$(nvim --version | grep -o 'v[0-9.]\+[0-9]')

if [ "$ACTUAL_VER" = "$NVER" ]; then
  echo already at the latest version $NVER.
  exit 0
fi

if [ "$OS" = "Arch Linux" ]; then
  sudo pacman  --noconfirm --needed -S make luajit luarocks cmake base-devel
elif [ "$OS" = "Manjaro Linux" ]; then
  echo manjaro
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  sudo apt install -y gperf luajit luarocks libuv1-dev libluajit-5.1-dev libunibilium-dev libmsgpack-dev libtermkey-dev libvterm-dev cmake libtool-bin
  sudo apt remove -y neovim
elif [ "$OS" = "Fedora" ]; then
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
else
  echo $OS is not yet implemented.
  exit 1
fi

cd projects

git clone git@github.com:neovim/neovim.git
cd neovim
git checkout master
git pull origin master
git checkout tags/$NVER
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
echo make install_local
sudo make clean
cd $HOME

echo nvim -u NORC file
echo "previous $ACTUAL_VER"

echo ":checkhealth"
python -m pip install --user --upgrade pynvim

exit 0
