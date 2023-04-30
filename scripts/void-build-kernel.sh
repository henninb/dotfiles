#!/bin/sh

if [ "$OS" = "Void" ]; then
  VER=5.6.4
  if [ ! -f "linux-$VER.tar.xz" ]; then
    wget "https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$VER.tar.xz"
  fi
  tar xf "linux-$VER.tar.xz"
  cd "linux-$VER" || exit

  if [ ! -f .config ]; then
    make menuconfig
  fi

  make -j"$(nproc)"

  doas make modules_install

  sudo cp System.map "/boot/System.map-$VER"
  sudo cp arch/x86/boot/bzImage "/boot/vmlinuz-$VER"
  sudo cp .config "/boot/config-$VER"
  doas dracut -f "initramfs-${VER}.img ${VER}_1"
  sudo cp "initramfs-$VER.img" /boot/

  doas update-grub
  echo sudo update-grub
  # uname -a
  echo "run on suse as void is dependant on suse's grub"
  echo sudo grub2-mkconfig -o /boot/grub2/grub.cfg
else
  echo "OS must be Void"
  exit 1
fi

exit 0

# vim: set ft=sh:
