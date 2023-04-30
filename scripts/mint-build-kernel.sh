#!/bin/sh

# sudo zypper install -y flex
# sudo zypper install -y libelf-devel
doas apt install libncurses-dev
doas apt-get install libncurses-dev flex bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf

VER=5.6.4
if [ ! -f "linux-5.6.4.tar.xz" ]; then
  wget "https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$VER.tar.xz"
fi
tar xf "linux-$VER.tar.xz"
cd "linux-$VER" || exit

if [ ! -f .config ]; then
  make menuconfig
fi

fakeroot make-kpkg --initrd --append-to-version=-customname kernel_image kernel_headers

cd ..
sudo dpkg -i linux-image-*.deb linux-headers-*.deb
doas update-grub

echo https://forums.linuxmint.com/viewtopic.php?t=131433

# make -j"$(nproc)"
# sudo make modules_install

# sudo cp System.map "/boot/System.map-$VER"
# sudo cp arch/x86/boot/bzImage "/boot/vmlinuz-$VER"
# sudo cp .config "/boot/config-$VER"
# # /lib/modules/5.6.2-1-default/
# sudo dracut -f "initramfs-$VER.img" "$VER-1-default"
# sudo cp "initramfs-$VER.img" /boot/
# sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# sudo update-grub
# echo sudo update-grub
# uname -a

exit 0

# vim: set ft=sh:
