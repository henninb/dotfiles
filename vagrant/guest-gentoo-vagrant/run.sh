#!/bin/sh

echo virsh net-uuid br1
echo "https://computingforgeeks.com/managing-kvm-network-interfaces-in-linux/"
# sudo iptables -I FORWARD -m physdev --physdev-is-bridged -j ACCEPT
echo vagrant destroy
echo rm -rf .vagrant
#vagrant up --provider vmware-desktop
vagrant up --provider=libvirt
#vagrant up --provider kvm
echo vagrant global-status
echo vagrant ssh
echo sudo virsh console guest-gentoo-vagrant_default

exit 0

sudo virsh attach-interface --domain pxe --type bridge --source br1 --model virtio --config --live
sudo virsh attach-interface --domain guest-ubuntu-vagrant_default --type bridge --source br1 --model virtio --config --live
