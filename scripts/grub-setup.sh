#!/bin/sh

echo next boot will be into windows - onetime
echo /etc/default/grub set DEFAULT = saved
echo sudo grub-editenv - set saved_entry=2
echo GRUB_DEFAULT="Advanced options for Gentoo GNU/Linux>Gentoo GNU/Linux, with Linux 5.2.1-aufs"
echo sudo grub-reboot '1>3'
echo sudo grub-editenv list

echo cat /etc/default/grub
echo GRUB_CMDLINE_LINUX="user_namespace.enable=1"
echo sudo grub-mkconfig -o /boot/grub/grub.cfg

cat <<  EOF > "$HOME/tmp/40_custom"
#!/bin/sh
exec tail -n +3 "$0"

# this file name should be 40_custom
# sudo cp grub_40_custom /etc/grub.d/40_custom
# sudo update-grub
# validate /boot/grub/grub.cfg

menuentry "Ubuntu 20.04 - bh" {
  set root=(fd0)
  linux /boot/vmlinuz-5.4.0-26-generic root=UUID=6a0dfb06-5737-4b44-92fc-334f6ba0dc7e rw quiet
  initrd /boot/initrd.img-5.4.0-26-generic
}
# installed in bedroom on arch
menuentry "CentOS-7 5.0.2-1" {
  set root=(hd2,4)
  linux /boot/vmlinuz-5.0.2-1.el7.elrepo.x86_64 root=UUID=7555bb30-68c4-45f6-a24f-f4c4e4f91c26 rw quiet
  initrd /boot/initramfs-5.0.2-1.el7.elrepo.x86_64.img
}

menuentry "Windows 10" {
  set root=(hd2,1)
  chainloader +1
}

# installed in another system
menuentry "Mint 19.3" {
  set root=(hd0,1)
  linux /boot/vmlinuz-4.15.0-20-generic root=UUID=ffb5a152-1ca8-47a2-8629-443b59d81b41 ro quiet splash
  initrd /boot/initrd.img-4.15.0-20-generic
}

# to get UUID
# sudo blkid
menuentry "Arch Linux" {
  set root=(hd1,gpt7)
  linux /vmlinuz-linux root=/dev/nvme1n1p6
  initrd /initramfs-linux.img
}

menuentry "Windows 10 gpt2" {
  set root=(hd1,gpt2)
  chainloader /EFI/Microsoft/Boot/bootmgfw.efi
}

menuentry "System Reboot" {
  echo "System Reboot"
  reboot
}

menuentry "System Shutdown" {
  echo "System Shutdown"
  halt
}
EOF

if grep -q "console=tty1" /etc/default/grub; then
    echo "The console=tty1 parameter is already set in the bootloader configuration file."
else
    echo "The console=tty1 parameter is not set in the bootloader configuration file. Adding it now..."
    sudo sed -i 's/^GRUB_CMDLINE_LINUX="\(.*\)"$/GRUB_CMDLINE_LINUX="\1 console=tty1"/' /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

echo cp sudo cp "$HOME/tmp/40_custom" /etc/grub.d/40_custom

if ip addr show | grep 192.168.10.135; then
  sudo grub-editenv - set next_entry='Windows 10 (loader) on /dev/sdb1'
  sudo grub-editenv - set saved_entry=1
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  sudo grub-editenv list
  echo sudo reboot - to reboot into windows
  exit 0
fi

# Mint Linux
# ip addr show | grep 192.168.100.217
if [ "$(uname -n)" = "silverfox" ]; then
  sudo grub-editenv - set next_entry='Windows Boot Manager (on /dev/nvme0n1p2)'
  sudo grub-editenv - set saved_entry=1
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  sudo grub-editenv list
  echo sudo reboot - to reboot into windows
  exit 0
fi

# Arch Linux
if [ "$(uname -n)" = "archlinux" ]; then
# if ip addr show | grep 192.168.100.208; then
  sudo grub-editenv - set next_entry='Windows 10 gpt2'
  sudo grub-editenv - set saved_entry=1
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  sudo grub-editenv list
  echo sudo reboot - to reboot into windows
  exit 0
fi


exit 0

# vim: set ft=sh:
