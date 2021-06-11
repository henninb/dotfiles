#!/bin/sh

sudo pacman --noconfirm --needed -S virt-viewer

iso_file=haiku-release-anyboot.iso
sudo virsh undefine guest-haiku

if [ ! -f "/var/lib/libvirt/boot/${iso_file}" ]; then
  scp "pi:/home/pi/downloads/${iso_file}" .
  sudo mv "${iso_file}" /var/lib/libvirt/boot/
fi

sudo fallocate -l 4G /var/kvm/images/guest-haiku.img
sudo chmod 777 /var/kvm/images/guest-haiku.img

# sudo virt-install --name=guest-haiku --ram=2048 --vcpus=2 --os-type=generic --disk path=/var/lib/libvirt/images/guest-haiku.img,size=4 --graphics none --location /var/lib/libvirt/images/haiku-release-anyboot.iso --extra-args console=ttyS0

sudo virt-install \
--virt-type=kvm \
--name guest-haiku \
--memory=1024,maxmemory=2048 \
--vcpus=1,maxvcpus=2 \
--os-type=generic \
--virt-type=kvm \
--hvm \
--cdrom=/var/lib/libvirt/boot/${iso_file} \
--network=bridge=br0,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/guest-haiku.qcow2,size=40,bus=virtio,format=qcow2

exit 0
