#!/usr/bin/env sh

if [ "$OS" = "FreeBSD" ]; then
  sudo mkdir -p /vm
  sudo mkdir -p /vm/iso
  sudo pkg install -y vm-bhyve grub2-bhyve qemu-utils bhyve-rc bhyve-firmware uefi-edk2-bhyve chyves
  sudo sysrc vm_enable="YES"
  sudo sysrc vm_dir="/vm"
  sudo sysrc cloned_interfaces="bridge0 tap0 bridge1 tap1 bridge2 tap2 lo1"
  sudo sysrc ifconfig_bridge0="addm alc0 addm tap0 up"
  sudo sysrc zfs_enable="YES"
  echo sudo sysctl net.link.tap.up on open=1
  echo 'net.link.tap.up on open=1' | sudo tee -a /etc/sysctl.conf

  echo sudo sysctl net.inet.ip.forwarding=1
  echo 'net.inet.ip.forwarding=1' | sudo tee -a /etc/sysctl.conf

  echo 'if_bridge_load="YES"' | sudo tee -a /boot/loader.conf
  echo 'if_tap_load="YES"' | sudo tee -a /boot/loader.conf
  echo 'vmm_load="YES"' | sudo tee -a /boot/loader.conf
  echo 'nmdm_load="YES"' | sudo tee -a /boot/loader.conf

  sudo truncate -s 1G /usr/local/bhyvefs
  sudo zfs create /usr/local/bhyvefs
  sudo zpool create -f zroot /usr/local/bhyvefs

  echo sudo ifconfig tap0 create
  echo sudo ifconfig bridge0 create
  echo sudo ifconfig tap1 create
  echo sudo ifconfig bridge1 create
  sudo vm init
  echo sudo cp '/usr/local/share/examples/vm-bhyve/* /vm/.templates/'
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0
