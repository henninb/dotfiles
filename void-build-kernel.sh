#!/bin/sh
# xbps-install bc wget

wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.6.2.tar.xz
tar xf linux-5.6.2.tar.xz
cd linux-5.6.2

# cp /boot/config-3.17.1_1 .config

make -j"$(nproc)"

make modules_install firmware_install

sudo cp System.map /boot/System.map-5.6.2
sudo cp arch/x86/boot/bzImage /boot/vmlinuz-5.6.2
sudo cp .config /boot/config-5.6.2
sudo dracut -f initramfs-5.6.2.img 5.6.2
sudo cp initramfs-5.6.2.img /boot/

# sudo update-grub
# uname -a

exit 0
