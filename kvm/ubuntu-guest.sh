#!/bin/sh

sudo pacman --noconfirm --needed -S virt-viewer

iso_file=ubuntu-20.04-desktop-amd64.iso
sudo virsh shutdown guest-ubuntu
sudo virsh undefine guest-ubuntu
sudo mkdir -p /var/kvm/images

if [ ! -f "/var/lib/libvirt/boot/${iso_file}" ]; then
  scp "pi:/home/pi/downloads/${iso_file}" .
  sudo mv "${iso_file}" /var/lib/libvirt/boot/
fi

# sudo fallocate -l 10G /var/kvm/images/guest-ubuntu.img
# sudo chmod 777 /var/kvm/images/guest-ubuntu.img

sudo virt-install \
--virt-type=kvm \
--name guest-ubuntu \
--memory=4096,maxmemory=4096 \
--vcpus=1,maxvcpus=2 \
--os-type=generic \
--virt-type=kvm \
--hvm \
--cdrom=/var/lib/libvirt/boot/${iso_file} \
--network=bridge=virbr0,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/guest-ubuntu.qcow2,size=40,bus=virtio,format=qcow2

exit 0
