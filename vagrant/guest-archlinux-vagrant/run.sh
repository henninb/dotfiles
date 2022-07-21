#!/bin/sh

unset GEM_ROOT
unset GEM_HOME
unset GEM_PATH

vagrant box add archlinux/archlinux --provider=libvirt

#sudo iptables -I FORWARD -m physdev --physdev-is-bridged -j ACCEPT
echo vagrant destroy
echo rm -rf .vagrant
vagrant up --provider=libvirt
vagrant global-status
echo vagrant ssh
echo sudo virsh console guest-archlinux-vagrant_default
echo vagrant box update

exit 0
