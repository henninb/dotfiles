#!/bin/sh

VER=$(curl -s https://www.python.org/downloads/ | grep -o 'Python-[0-9.]\+[0-9].tar.xz' | head -1 | sed 's/.tar.xz//' | sed 's/Python-//')

# build() {
#   if [ ! -f Python-${VER}.tar.xz ]; then
#     rm -rf Python-*.tar.xz
#     wget https://www.python.org/ftp/python/${VER}/Python-${VER}.tar.xz
#   fi
#   tar -xf Python-${VER}.tar.xz
#   cd Python-${VER}
#   ./configure --enable-optimizations
#   make -j$(nproc)
#   sudo make altinstall
# }

# pip_ins() {
#   pip show $1 > /dev/null
#   if [ $? -ne 0 ]; then
#     pip install $1 --user
#   fi
# }

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ] || [ "$OS" = "Debian GNU/Linux" ]; then
  sudo apt install -y python3.7 python3.7-venv python-pip python3-pip libssl-dev libffi-dev python-setuptools python3.7-dev
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S python python3
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y epel-release python python-devel
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "Fedora Linux" ]; then
  echo "fedora"
elif [ "$OS" = "void" ]; then
  echo "void"
elif [ "$OS" = "Gentoo" ]; then
  echo sudo emerge --update --newuse python
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y python39
  sudo pkg install -y py39-pip
else
  echo "$OS is not yet implemented."
  exit 1
fi

echo $VER
echo

curl -s https://bootstrap.pypa.io/get-pip.py --output "$HOME/tmp/get-pip3.py"
python3 "$HOME/tmp/get-pip3.py"

curl -s https://bootstrap.pypa.io/pip/2.7/get-pip.py --output "$HOME/tmp/get-pip2.py"
python2 "$HOME/tmp/get-pip2.py"

exit 0

# vim: set ft=sh
