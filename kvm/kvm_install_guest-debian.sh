#!/bin/sh

sudo virsh destroy guest-debian
sudo virsh undefine guest-debian

sudo fallocate -l 10G /var/kvm/images/guest-debian.img
sudo chmod 777 /var/kvm/images/guest-debian.img

sudo virt-install --name guest-debian --ram 2048 --disk path=/var/kvm/images/guest-debian.img,size=10 --vcpus 1 --os-type linux --os-variant debian9 --graphics none --location 'http://ftp.us.debian.org/debian/dists/stretch/main/installer-amd64/' --extra-args console=ttyS0 
echo "add console=ttyS0 to the grub boot parms -- fixes console issues."
echo "add this to leverage the host cpu --cpu host"

exit 0

added console=ttyS0 to the boot parms in grub fixes console issues.
 sudo systemctl enable getty@ttyS0
[sudo] password for henninb:
Created symlink /etc/systemd/system/getty.target.wants/getty@ttyS0.service → /lib/systemd/system/getty@.service.
[henninb@mintbox ~]$ sudo systemctl start getty@ttyS0
