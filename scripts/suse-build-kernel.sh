#!/bin/sh

sudo zypper install -y flex
sudo zypper install -y libelf-devel

VER=6.1.2
if [ ! -f "linux-$VER.tar.xz" ]; then
  wget "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-$VER.tar.xz" -O "$HOME/tmp/linux-$VER.tar.xz"
fi

sudo tar -xvf "$HOME/tmp/linux-$VER.tar.xz" -C /usr/src
rm "$HOME/tmp/linux-$VER.tar.xz"

# cd "$HOME/tmp" || exit
# tar xf "$HOME/tmp/linux-$VER.tar.xz"
cd "/usr/src/linux-$VER" || exit

if [ ! -f .config ]; then
  make menuconfig
fi

make -j"$(nproc)"
exit 1

sudo make modules_install

sudo cp System.map "/boot/System.map-$VER"
sudo cp arch/x86/boot/bzImage "/boot/vmlinuz-$VER"
sudo cp .config /boot/config-$VER
# /lib/modules/5.6.2-1-default/
sudo dracut -f "initramfs-$VER.img" "$VER-1-default"
sudo cp "initramfs-$VER.img" /boot/
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# sudo update-grub
# echo sudo update-grub
# uname -a

exit 0

# vim: set ft=sh:
