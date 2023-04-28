#!/bin/sh

VER=$(curl https://www.python.org/downloads/ | grep -o 'Python-[0-9.]\+[0-9].tar.xz' | head -1 | sed 's/.tar.xz//' | sed 's/Python-//')

build() {
  if [ ! -f "Python-${VER}.tar.xz" ]; then
    rm -rf Python-*.tar.xz
    wget "https://www.python.org/ftp/python/${VER}/Python-${VER}.tar.xz"
  fi
  tar -xf "Python-${VER}.tar.xz"
  cd "Python-${VER}" || exit
  ./configure --enable-optimizations
  make -j "$(nproc)"
  sudo make altinstall
}

pip_ins() {
  if ! pip show "$1" > /dev/null; then
    pip install "$1" --user
  fi
}

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y python3.7 python3.7-venv python-pip python3-pip libssl-dev libffi-dev python-setuptools python3.7-dev
  echo build
  alias pip='pip3'
  alias python='python3'
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -S python python-pip python2-pip python2
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y epel-release python python-pip wget gcc python-devel
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge python dev-python/pip
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y python36 py36-pip
else
  echo "$OS is not yet implemented."
  exit 1
fi

#pip install -U $(pip freeze | awk '{split($0, a, "=="); print a[1]}')
pip_ins wheel
pip_ins ansible
pip_ins ranger-fm
pip_ins youtube-dl
pip_ins powerline-status
pip_ins cheat
#pip_ins greg
pip_ins mdv
pip_ins pexect
pip_ins pssh
#pip_ins parallel-ssh
pip_ins azure_cli
pip_ins glances #process watcher
pip_ins tuir #redit client
pip_ins mlbv

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo pyenv install 2.7.8

echo python3 -m venv my-project-env
echo .local/lib/
ls -ld .local/lib/python*
python --version

echo https://pypi.org/project/blessed/

exit 0

# vim: set ft=sh:
