#!/bin/sh

echo vagrant box add archlinux/archlinux --provider=libvirt

#sudo iptables -I FORWARD -m physdev --physdev-is-bridged -j ACCEPT
vagrant destroy
rm -rf .vagrant
vagrant up --provider=libvirt
echo vagrant global-status
echo vagrant ssh
echo sudo virsh console guest-archlinux-vagrant_default
echo vagrant box update

exit 0
