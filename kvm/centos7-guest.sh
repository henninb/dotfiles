#!/bin/sh

if [ $# -gt 1 ]; then
    echo "Usage: $0 [remove y/n]"
    exit 1
fi

remove=$1
iso_file=CentOS-7-x86_64-Minimal-1810.iso


virsh shtudwon guest-centos7
virsh destroy guest-centos7
virsh undefine guest-centos7

sudo mkdir -p /var/lib/libvirt/boot
sudo mkdir -p /var/lib/libvirt/images
sudo chown -R qemu:qemu /var/lib/libvirt/boot
sudo chown -R qemu:qemu /var/lib/libvirt/images
sudo rm /var/lib/libvirt/images/guest-centos7.qcow2

if [ "$remove" = "y" ]; then
  echo "remove only"
  exit 1
fi

if [ ! -f "/var/lib/libvirt/boot/${iso_file}" ]; then
  scp "pi:/home/pi/shared/template/iso/${iso_file}" .
  sudo mv "${iso_file}" /var/lib/libvirt/boot/
fi

sudo virt-install --name=guest-centos7 --ram=2048 --vcpus=1 --os-type=linux --os-variant=rhel7.0 --disk path=/var/lib/libvirt/images/guest-centos7.img,size=10 --graphics none --location /var/lib/libvirt/images/CentOS-7-x86_64-NetInstall-1810.iso --extra-args console=ttyS0

exit 0
