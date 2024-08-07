#!/bin/sh

if command -v zypper; then
  doas zypper install -y flex
  doas zypper install -y libelf-devel
fi

if command -v apt; then
  doas apt install -y libncurses-dev
  doas apt install -y libncurses-dev flex bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf
fi

VER=6.1.2
if [ ! -f "linux-$VER.tar.xz" ]; then
  wget "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-$VER.tar.xz" -O "$HOME/tmp/linux-$VER.tar.xz"
fi

sudo tar -xvf "$HOME/tmp/linux-$VER.tar.xz" -C /usr/src
rm "$HOME/tmp/linux-$VER.tar.xz"

# cd "$HOME/tmp" || exit
# tar xf "$HOME/tmp/linux-$VER.tar.xz"
cd "/usr/src/linux-$VER" || exit

# cp /boot/config-$(uname -r) ${HOME}/kernel-xe-max/.config
# sed -i 's%CONFIG_SYSTEM_TRUSTED_KEYS=".*"%CONFIG_SYSTEM_TRUSTED_KEYS=""%' ${HOME}/kernel-xe-max/.config
# make olddefconfig

if [ ! -f .config ]; then
  doas make menuconfig
fi
sudo scripts/config --disable SYSTEM_TRUSTED_KEYS
sudo scripts/config --disable SYSTEM_REVOCATION_KEYS

doas make -j"$(nproc)"
#sudo make
exit 1

doas make modules_install

sudo cp System.map "/boot/System.map-$VER"
sudo cp arch/x86/boot/bzImage "/boot/vmlinuz-$VER"
sudo cp .config /boot/config-$VER
# /lib/modules/5.6.2-1-default/
doas dracut -f "initramfs-$VER.img" "$VER-1-default"
sudo cp "initramfs-$VER.img" /boot/
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# sudo update-grub
# echo sudo update-grub
# uname -a

exit 0

# vim: set ft=sh:
