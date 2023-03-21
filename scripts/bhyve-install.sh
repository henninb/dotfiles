#!/usr/bin/env sh

if [ "$OS" = "FreeBSD" ]; then
  sudo mkdir -p /vm
  sudo mkdir -p /vm/iso
  sudo pkg install -y vm-bhyve
  sudo pkg install -y grub2-bhyve
  sudo pkg install -y bhyve-rc
  sudo pkg install -y bhyve-firmware
  sudo pkg install -y sysrc
  sudo sysrc vm_enable="YES"
  sudo sysrc vm_dir="/vm"
  # sudo sysrc cloned_interfaces="bridge0 tap0 bridge1 tap1 bridge2 tap2 lo1"
  # sudo sysrc ifconfig_bridge0="addm alc0 addm tap0 up"
  # sudo sysrc zfs_enable="YES"
  sudo vm switch create public
  sudo vm switch info
  echo sudo sysctl net.link.tap.up on open=1
  #echo 'net.link.tap.up on open=1' | sudo tee -a /etc/sysctl.conf
  sudo kldload if_bridge if_tap nmdm vmm

  echo sudo sysctl net.inet.ip.forwarding=1
  echo 'net.inet.ip.forwarding=1' | sudo tee -a /etc/sysctl.conf

  echo 'if_bridge_load="YES"' | sudo tee -a /boot/loader.conf
  echo 'if_tap_load="YES"' | sudo tee -a /boot/loader.conf
  echo 'vmm_load="YES"' | sudo tee -a /boot/loader.conf
  echo 'nmdm_load="YES"' | sudo tee -a /boot/loader.conf

  # sudo truncate -s 1G /usr/local/bhyvefs
  # sudo zfs create /usr/local/bhyvefs
  # sudo zpool create -f zroot /usr/local/bhyvefs

  echo sudo ifconfig tap0 create
  echo sudo ifconfig bridge0 create
  echo sudo ifconfig tap1 create
  echo sudo ifconfig bridge1 create
#  sudo zfs create -o mountpoint=/vm zroot/vm
  sudo vm init
  sudo cp -v /usr/local/share/examples/vm-bhyve/* /vm/.templates/
  sudo vm switch create public
#  sudo vm switch add public em0
  sudo vm switch add public vtnet0
  sudo vm switch add public re0
  sudo sysctl net.link.tap.up on open=1
  sudo vm switch info public

else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
