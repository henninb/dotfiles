#!/bin/sh

echo next boot will be into windows - onetime
echo /etc/default/grub set DEFAULT = saved
echo sudo grub-editenv - set saved_entry=2
echo GRUB_DEFAULT="Advanced options for Gentoo GNU/Linux>Gentoo GNU/Linux, with Linux 5.2.1-aufs"
echo sudo grub-reboot '1>3'
echo sudo grub-editenv list

# CentOS
#ip addr show | grep 192.168.100.135
#if [ $? -eq 0 ]; then
#  sudo grub2-editenv - set next_entry='Windows 10 (loader) on /dev/sdb1'
#  sudo grub2-editenv - set saved_entry=1
#  sudo grub2-mkconfig -o /boot/grub2/grub.cfg
#  sudo grub2-editenv list
#  echo sudo reboot - to reboot into windows
#  exit 0
#fi

if ip addr show | grep 192.168.100.135; then
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
if ip addr show | grep 192.168.100.218; then
  sudo grub-editenv - set next_entry='Windows 10 gpt2'
  sudo grub-editenv - set saved_entry=1
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  sudo grub-editenv list
  echo sudo reboot - to reboot into windows
  exit 0
fi

exit 0
