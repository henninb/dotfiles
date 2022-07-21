#!/bin/sh

echo vagrant destroy
echo rm -rf .vagrant
vagrant up --provider=libvirt
echo vagrant global-status
echo vagrant ssh
echo virsh console guest-gentoo-vagrant_default

exit 0
