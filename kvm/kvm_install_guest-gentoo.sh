#!/bin/sh


sudo virsh destroy guest-gentoo
sudo virsh undefine guest-gentoo
sudo mkdir -p /var/kvm/images

if [ ! -f install-amd64-minimal-20190630T214502Z.iso ]; then
  wget http://distfiles.gentoo.org/releases/amd64/autobuilds/20190630T214502Z/install-amd64-minimal-20190630T214502Z.iso
  #scp pi@192.168.100.25:/home/pi/Downloads/CentOS-7-x86_64-NetInstall-1810.iso /tmp/CentOS-7-x86_64-NetInstall-1810.iso
fi

sudo chmod 777 install-amd64-minimal-20190630T214502Z.iso
sudo fallocate -l 10G /var/kvm/images/guest-gentoo.img
sudo chmod 777 /var/kvm/images/guest-gentoo.img

# works for iso media
#sudo virt-install --name=guest-gentoo --ram=2048 --vcpus=1 --os-type=linux --os-variant=rhel7.0 --disk path=/var/lib/libvirt/images/guest-gentoo.img,size=10 --graphics none --location install-amd64-minimal-20190630T214502Z.iso --extra-args console=ttyS0
sudo virt-install --name=guest-gentoo --ram=2048 --vcpus=1 --os-type=linux --disk path=/var/lib/libvirt/images/guest-gentoo.img,size=10 --graphics none --location install-amd64-minimal-20190630T214502Z.iso --extra-args console=ttyS0

exit 0
