#!/bin/sh

echo vagrant destroy
vagrant up --provider=libvirt
echo vagrant global-status
echo vagrant ssh
echo sudo virsh console guest-openbsd-vagrant_default

exit 0
