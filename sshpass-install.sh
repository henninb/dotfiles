#!/bin/sh

cd "$HOME/projects" || exit
rm -rf automake-1.15.tar.gz
wget https://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz
tar xvf automake-1.15.tar.gz
cd automake-1.15 || exit
./configure  --prefix=/opt/aclocal-1.15
make
sudo mkdir -p /opt
sudo make install

cd "$HOME/projects" || exit
git clone git://github.com/kevinburke/sshpass.git
cd sshpass || exit
export PATH=/opt/aclocal-1.15/bin:$PATH
aclocal --version
# autoreconf -f -i.
touch README
./configure
make
sudo make install

exit 0
