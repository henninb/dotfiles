#!/bin/sh

wget https://dl-cdn.archlinuxlinux.org/archlinux/v3.13/releases/x86_64/archlinux-minirootfs-3.13.5-x86_64.tar.gz
wget https://mirror.rackspace.com/archlinux/iso/latest/archlinux-bootstrap-2020.04.01-x86_64.tar.gz

sudo mkdir -p /compat/archlinux/dev
sudo mkdir -p /compat/archlinux/proc
sudo mkdir -p /compat/archlinux/sys
sudo mkdir -p /compat/archlinux/shm

sudo mv archlinux-minirootfs-3.13.5-x86_64.tar.gz /compat/archlinux
cd /compat/archlinux
sudo tar xzvf archlinux-minirootfs-3.13.5-x86_64.tar.gz
sudo rm archlinux-minirootfs-3.13.5-x86_64.tar.gz
cd -

echo sudo chroot /compat/archlinux /bin/sh
kldstat | grep linux

exit 0

devfs /compat/archlinux/dev devfs  rw 0 0
linprocfs /compat/archlinux/proc linprocfs   rw 0 0
linsysfs /compat/archlinux/sys linsysfs     rw 0 0
tmpfs /compat/archlinux/shm tmpfs rw,mode=1777 0 0

echo "nameserver 1.1.1.1" > /etc/resolv.conf
apk add python3
