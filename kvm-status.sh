#!/bin/sh

sudo echo
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

echo virsh net-dhcp-leases default
virsh net-dhcp-leases default
brctl show

echo virsh pool-list --all
virsh pool-list --all

echo virsh -c qemu+ssh://vagrant@ho/system

echo ls -l /var/lib/libvirt/dnsmasq

exit 0
