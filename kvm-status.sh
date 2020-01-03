#!/bin/sh

sudo echo
echo sudo virsh net-list --all
sudo virsh net-list --all
echo

echo sudo virsh list --all
sudo virsh list --all
echo

#sudo virsh net-autostart default

# start and stop
echo "sudo virsh start <domain>"
echo "sudo virsh edit <domain>"
echo "sudo virsh shutdown <domain>"
echo "sudo virsh destroy <domain>"
echo "sudo virsh undefine <domain>"
echo "sudo virsh net-autostart <network>"
echo "sudo virsh pool-autostart default"
sudo virsh pool-autostart default

echo "sudo virsh net-autostart default"
sudo virsh net-autostart default
#sudo systemctl enable serial-getty@ttyS0.service
#sudo systemctl start serial-getty@ttyS0.service

echo sudo virsh net-dhcp-leases default
sudo virsh net-dhcp-leases default
brctl show

echo sudo virsh pool-list --all
sudo virsh pool-list --all

echo sudo virsh -c qemu+ssh://vagrant@ho/system

echo ls -l /var/lib/libvirt/dnsmasq

exit 0
