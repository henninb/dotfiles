#!/bin/sh

echo vagrant destroy
echo rm -rf .vagrant
vagrant up --provider=libvirt
echo vagrant global-status
echo vagrant ssh
echo sudo virsh console guest-ubuntu-vagrant_default

exit 0
