#!/bin/sh


sudo virsh destroy guest-centos7
sudo virsh undefine guest-centos7
sudo mkdir -p /var/kvm/images
sudo mkdir -p /var/lib/libvirt/images

if [ ! -f /tmp/CentOS-7-x86_64-NetInstall-1810.iso ]; then
  scp pi@192.168.100.25:/home/pi/Downloads/CentOS-7-x86_64-NetInstall-1810.iso /tmp/CentOS-7-x86_64-NetInstall-1810.iso
fi

sudo chmod 777 /tmp/CentOS-7-x86_64-NetInstall-1810.iso
echo http://mirrors.umflint.edu/CentOS/7.6.1810/isos/x86_64/CentOS-7-x86_64-Minimal-1810.iso
sudo fallocate -l 10G /var/kvm/images/guest-centos7.img
sudo chmod 777 /var/kvm/images/guest-centos7.img

#fails on centos boot
#sudo virt-install --name guest-centos7 --ram=2048 --disk path=/var/kvm/images/guest-centos7.img,size=10 --vcpus 1 --os-type linux --os-variant rhel7.0 --graphics none --location 'http://bay.uchicago.edu/centos/7.6.1810/os/x86_64/' --extra-args console=ttyS0

sudo mv //tmp/CentOS-7-x86_64-NetInstall-1810.iso /var/lib/libvirt/images/
# works for iso media
sudo virt-install --name=guest-centos7 --ram=2048 --vcpus=1 --os-type=linux --os-variant=rhel7.0 --disk path=/var/lib/libvirt/images/guest-centos7.img,size=10 --graphics none --location /var/lib/libvirt/images/CentOS-7-x86_64-NetInstall-1810.iso --extra-args console=ttyS0

exit 0
