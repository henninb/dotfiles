#!/bin/sh

iso_file=openbsd-7.0.iso

virsh shutdown guest-openbsd
virsh undefine guest-openbsd

sudo rm -rf /var/lib/libvirt/images/guest-openbsd.qcow2

if [ ! -f "/var/lib/libvirt/boot/${iso_file}" ]; then
  scp "pi:/home/pi/shared/template/iso/${iso_file}" .
  sudo mv "${iso_file}" /var/lib/libvirt/boot/
fi

osinfo-query os | grep openbsd6.9

sudo virt-install \
--virt-type=kvm \
--name guest-openbsd \
--memory=2048,maxmemory=2048 \
--vcpus=1,maxvcpus=2 \
--os-variant=openbsd6.9 \
--virt-type=kvm \
--hvm \
--cdrom=/var/lib/libvirt/boot/${iso_file} \
--network=bridge=virbr0,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/guest-openbsd.qcow2,size=10,bus=virtio,format=qcow2

exit 0
