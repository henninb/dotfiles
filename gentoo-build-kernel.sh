#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  echo emerge -uDNa @world
  sudo emerge --update --newuse sys-kernel/gentoo-sources
  sudo emerge --update --newuse zfs
  # sudo emerge --update --newuse aufs-sources
  sudo PYTHON_SINGLE_TARGET="python3_7 (-pypy3) -python3_6" emerge --update --newuse dracut
  sudo emerge --update --newuse fakeroot
  sudo emerge --update --newuse pciutils
  sudo eselect kernel list
  echo sudo eselect kernel set 1
  sudo eselect kernel set 1

  echo TODO: should I be exiting here?
  echo TODO: add audio into the kernel
  exit 1
  cd /usr/src/linux || exit
  cp -v /usr/src/linux/.config "${HOME}/kernel-config-$(uname -r)"

  echo sudo make mrpropper
  sudo make menuconfig
  sudo make -j"$(nproc)"
  sudo mount /dev/sda1 /boot
  sudo make modules_install
  sudo make install
  cd /boot && sudo dracut --kver 5.4.60-gentoo
  echo sudo grub-install /dev/sda
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  sudo grep gnulinux /boot/grub/grub.cfg
  echo sudo reboot
fi

echo qpkg  -v gentoo-sources
# sudo emerge -C sys-kernel/gentoo-sources-4.19.97
echo sudo rm -r /usr/src/linux-${old_kernel}* || { echo "Failed to remove old kernel sources"; exit 1; }
echo sudo rm -r /boot/*${old_kernel}* || { echo "Failed to remove boot files"; exit 1; }
echo sudo rm -r /lib/modules/${old_kernel}* || { echo "Failed to remove modules"; exit 1; }

exit 0
