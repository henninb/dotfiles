#!/bin/sh

if ! command -v virsh; then
  echo "install kvm"
  exit 1
fi
virsh net-start default

doas echo
echo virsh net-list --all
virsh net-list --all
echo

echo virsh list --all
virsh list --all
echo

#sudo virsh net-autostart default

# start and stop
echo "virsh start <domain>"
echo "virsh edit <domain>"
echo "virsh shutdown <domain>"
echo "virsh destroy <domain>"
echo "virsh undefine <domain>"
echo "virsh net-autostart <network>"
echo "virsh pool-autostart default"
virsh pool-autostart default

echo "virsh net-autostart default"
virsh net-autostart default
#sudo systemctl enable serial-getty@ttyS0.service
#sudo systemctl start serial-getty@ttyS0.service

echo list ip address
echo virsh net-dhcp-leases default
virsh net-dhcp-leases default

echo list ip address
echo virsh net-dhcp-leases vagrant-libvirt
virsh net-dhcp-leases vagrant-libvirt

brctl show

echo virsh pool-list --all
echo virsh pool-destroy images
virsh pool-list --all

echo virsh -c qemu+ssh://vagrant@ho/system

echo ls -l /var/lib/libvirt/dnsmasq

exit 0

# vim: set ft=sh:
