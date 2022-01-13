#!/bin/sh

# wget https://github.com/fastly/cli/releases/download/v1.3.0/fastly_1.3.0_linux_amd64.rpm

sudo pacman --noconfirm --needed -S fakeroot
sudo pacman --noconfirm --needed -S rpm
sudo xbps-install -y rpm

wget 'https://github.com/fastly/cli/releases/download/v1.4.0/fastly_1.4.0_linux_amd64.rpm' -O "$HOME/projects/fastly_1.4.0_linux_amd64.rpm"

# wget 'https://github.com/fastly/cli/archive/refs/tags/v1.4.0.tar.gz' -O ~/projects/fastly-v1.4.0.tar.gz
# cd ~/projects/ || exit
# tar xvf fastly-v1.4.0.tar.gz
# cd cli-1.3.0 || exit
# make
# make install
# rm -rf "$HOME/projects/fastly-v1.4.0.tar.gz"

sudo rpm -i --nodeps ~/projects/fastly_1.4.0_linux_amd64.rpm

mkdir ~/projects/edge
cd ~/projects/edge || exit
fastly compute init

exit 0
