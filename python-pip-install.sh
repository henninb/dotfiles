#!/bin/sh

VER=$(curl -s https://www.python.org/downloads/ | grep -o 'Python-[0-9.]\+[0-9].tar.xz' | head -1 | sed 's/.tar.xz//' | sed 's/Python-//')

build() {
  if [ ! -f Python-${VER}.tar.xz ]; then
    rm -rf Python-*.tar.xz
    wget https://www.python.org/ftp/python/${VER}/Python-${VER}.tar.xz
  fi
  tar -xf Python-${VER}.tar.xz
  cd Python-${VER}
  ./configure --enable-optimizations
  make -j$(nproc)
  sudo make altinstall
}

pip_ins() {
  pip show $1 > /dev/null
  if [ $? -ne 0 ]; then
    pip install $1 --user
  fi
}

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y python3.7 python3.7-venv python-pip python3-pip libssl-dev libffi-dev python-setuptools python3.7-dev
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  #sudo pacman --noconfirm --needed -S python python-pip python2-pip python2
  sudo pacman --noconfirm --needed -S python python3
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y epel-release python python-devel
elif [ "$OS" = "void" ]; then
  echo
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse python
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y python36 py36-pip
else
  echo $OS is not yet implemented.
  exit 1
fi

curl -O https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
sudo python2 get-pip.py

exit 0
