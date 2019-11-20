#!/bin/sh

if [ "$OS" = "Linux Mint" ]; then
  cd /tmp/

  wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.0/linux-headers-5.0.0-050000_5.0.0-050000.201903032031_all.deb
  wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.0/linux-headers-5.0.0-050000-generic_5.0.0-050000.201903032031_amd64.deb
  wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.0/linux-image-unsigned-5.0.0-050000-generic_5.0.0-050000.201903032031_amd64.deb
  wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.0/linux-modules-5.0.0-050000-generic_5.0.0-050000.201903032031_amd64.deb
  sudo dpkg -i *.deb
  cd $HOME
fi

exit 0
