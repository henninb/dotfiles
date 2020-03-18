#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse sys-kernel/gentoo-sources
  sudo emerge --update --newuse zfs
  sudo emerge --update --newuse aufs-sources

  sudo emerge --update --newuse fakeroot
  sudo emerge --update --newuse pciutils
  sudo eselect kernel list
  echo sudo eselect kernel set 1
  sudo eselect kernel set 2

  echo TODO: should I be exiting here?
  echo TODO: add audio into the kernel
  # exit 1
  cd /usr/src/linux || exit
  cp -v /usr/src/linux/.config ~/kernel-config-$(uname -r)

  echo sudo make mrpropper
  sudo make menuconfig
  sudo make -j$(nproc)
  sudo mount /dev/sdc1 /boot
  sudo make modules_install
  sudo make install
  echo sudo grub-install /dev/sdc
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  sudo grep gnulinux /boot/grub/grub.cfg
  echo sudo reboot
fi

exit 0


