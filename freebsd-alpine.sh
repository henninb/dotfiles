#!/bin/sh

wget https://dl-cdn.alpinelinux.org/alpine/v3.13/releases/x86_64/alpine-minirootfs-3.13.5-x86_64.tar.gz

sudo mkdir -p /compat/alpine/dev
sudo mkdir -p /compat/alpine/proc
sudo mkdir -p /compat/alpine/sys
sudo mkdir -p /compat/alpine/shm

sudo mv alpine-minirootfs-3.13.5-x86_64.tar.gz /compat/alpine
cd /compat/alpine
sudo tar xzvf alpine-minirootfs-3.13.5-x86_64.tar.gz
sudo rm alpine-minirootfs-3.13.5-x86_64.tar.gz
cd -

echo sudo chroot /compat/alpine /bin/sh
kldstat | grep linux

exit 0

devfs /compat/alpine/dev devfs  rw 0 0
linprocfs /compat/alpine/proc linprocfs   rw 0 0
linsysfs /compat/alpine/sys linsysfs     rw 0 0
tmpfs /compat/alpine/shm tmpfs rw,mode=1777 0 0

echo "nameserver 1.1.1.1" > /etc/resolv.conf
apk add python3
