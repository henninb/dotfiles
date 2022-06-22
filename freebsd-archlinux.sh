#!/bin/sh

log="$(pwd)/freebsd-archlinux.$$.log"

cat > archlinux-fstab <<EOF
devfs /compat/archlinux/dev devfs  rw 0 0
tmpfs /compat/archlinux/dev/shm tmpfs rw,mode=1777 0 0
fdescfs         /compat/archlinux/dev/fd   fdescfs         rw,late,linrdlnk             0       0
linprocfs /compat/archlinux/proc linprocfs   rw 0 0
linsysfs /compat/archlinux/sys linsysfs     rw 0 0
/tmp            /compat/archlinux/tmp      nullfs          rw,late                      0       0
/home           /compat/archlinux/home     nullfs          rw,late                      0       0
EOF

#wget https://mirror.rackspace.com/archlinux/iso/latest/archlinux-bootstrap-2021.05.01-x86_64.tar.gz

sudo mkdir -p /compat/archlinux/

sudo cp archlinux-bootstrap-2021.05.01-x86_64.tar.gz /compat/archlinux
cd /compat/archlinux || exit
#sudo tar xzvf archlinux-bootstrap-2021.05.01-x86_64.tar.gz --strip-components=1 2>&1 | tee -a "$log"
sudo tar xzvf archlinux-bootstrap-2021.05.01-x86_64.tar.gz --strip-components=1 2> "$log"
sudo mkdir -p /compat/archlinux/dev
sudo mkdir -p /compat/archlinux/proc
sudo mkdir -p /compat/archlinux/sys
sudo mkdir -p /compat/archlinux/dev/shm
sudo rm archlinux-bootstrap-2021.05.01-x86_64.tar.gz
cd - || exit
echo "nameserver 1.1.1.1" | sudo tee -a /compat/archlinux/etc/resolv.conf

cat archlinux-fstab

echo sudo chroot /compat/archlinux /bin/sh
kldstat | grep linux

exit 0

# vim: set ft=sh:

