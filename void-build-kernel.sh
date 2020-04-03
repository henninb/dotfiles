#!/bin/sh

if [ ! -f linux-5.6.2.tar.xz ]; then
  wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.6.2.tar.xz
fi
tar xf linux-5.6.2.tar.xz
cd linux-5.6.2

if [ ! -f .config ]; then
  make menuconfig
fi

make -j"$(nproc)"

sudo make modules_install

sudo cp System.map /boot/System.map-5.6.2
sudo cp arch/x86/boot/bzImage /boot/vmlinuz-5.6.2
sudo cp .config /boot/config-5.6.2
sudo dracut -f initramfs-5.6.2.img 5.6.2_1
sudo cp initramfs-5.6.2.img /boot/

sudo update-grub
echo sudo update-grub
# uname -a
echo "run on suse as void is dependant on suse's grub"
echo sudo grub2-mkconfig -o /boot/grub2/grub.cfg

exit 0
