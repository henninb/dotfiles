#!/bin/sh

# sudo zypper install -y flex
# sudo zypper install -y libelf-devel

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
# /lib/modules/5.6.2-1-default/
sudo dracut -f initramfs-5.6.2.img 5.6.2-1-default
sudo cp initramfs-5.6.2.img /boot/
# sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# sudo update-grub
# echo sudo update-grub
# uname -a

exit 0
