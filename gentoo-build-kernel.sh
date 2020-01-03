#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  sudo emerge sys-kernel/gentoo-sources
  sudo emerge zfs
  sudo emerge aufs-sources

  sudo emerge fakeroot
  sudo emerge pciutils
  sudo eselect kernel list
  echo sudo eselect kernel set 1

  exit 1
  cd /usr/src/linux
  cp -v /usr/src/linux/.config ~/kernel-config-$(uname -r)

  sudo make menuconfig
  sudo make -j$(nproc)
  sudo mount /dev/sdc1 /boot
  sudo make modules_install
  sudo make install
  echo sudo grub-install /dev/sdc
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  echo sudo reboot
fi

exit 0
