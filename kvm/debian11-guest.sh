#!/bin/sh

iso_file=debian-11.1.0-amd64-netinst.iso
virsh shutdown guest-debian
virsh undefine guest-debian

sudo mkdir -p /var/lib/libvirt/images/
sudo mkdir -p /var/lib/libvirt/boot/

if [ ! -f "/var/lib/libvirt/boot/${iso_file}" ]; then
  scp "pi:/home/pi/shared/template/iso/${iso_file}" .
  sudo mv "${iso_file}" /var/lib/libvirt/boot/
fi

echo osinfo-query os
# sudo fallocate -l 10G /var/kvm/images/guest-debian.img
# sudo chmod 777 /var/kvm/images/guest-debian.img

sudo virt-install \
--virt-type=kvm \
--name guest-debian \
--memory=4096,maxmemory=4096 \
--vcpus=1,maxvcpus=2 \
--os-type=debian9 \
--virt-type=kvm \
--hvm \
--cdrom=/var/lib/libvirt/boot/${iso_file} \
--network=bridge=virbr0,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/guest-debian.qcow2,size=40,bus=virtio,format=qcow2

exit 0
