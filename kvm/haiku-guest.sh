#!/bin/sh


sudo virsh destroy guest-haiku
sudo virsh undefine guest-haiku
sudo mkdir -p /var/kvm/images
sudo mkdir -p /var/lib/libvirt/images

sudo chmod 777 $HOME/haiku-release-anyboot.iso

sudo fallocate -l 4G /var/kvm/images/guest-haiku.img
sudo chmod 777 /var/kvm/images/guest-haiku.img

sudo cp $HOME/haiku-release-anyboot.iso /var/lib/libvirt/images/
sudo chmod 777 /var/lib/libvirt/images/haiku-release-anyboot.iso

sudo virt-install --name=guest-haiku --ram=2048 --vcpus=2 --os-type=linux --os-variant=rhel7.0 --disk path=/var/lib/libvirt/images/guest-haiku.img,size=4 --graphics none --location /var/lib/libvirt/images/haiku-release-anyboot.iso --extra-args console=ttyS0

exit 0
