#!/bin/sh

unset GEM_ROOT
unset GEM_HOME
unset GEM_PATH

sudo iptables -I FORWARD -m physdev --physdev-is-bridged -j ACCEPT
vagrant destroy
vagrant up --provider libvirt
echo vagrant ssh
echo sudo virsh console guest-alpine-vagrant_default

exit 0
