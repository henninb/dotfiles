#!/bin/sh

# iso_file=install-amd64-minimal-20220710T170538Z.iso
iso_file=archlinux-x86_64.iso
virsh shutdown guest-gentoo
virsh undefine guest-gentoo

sudo mkdir -p /var/lib/libvirt/boot
sudo rm -rf /var/lib/libvirt/images/guest-gentoo.qcow2

if [ ! -f "/var/lib/libvirt/boot/${iso_file}" ]; then
  scp "pi:/home/pi/shared/template/iso/${iso_file}" .
  sudo mv "${iso_file}" /var/lib/libvirt/boot/
fi

exec sudo virt-install \
--virt-type=kvm \
--name guest-gentoo \
--memory=8192,maxmemory=8192 \
--vcpus=2,maxvcpus=2 \
--virt-type=kvm \
--hvm \
--cdrom=/var/lib/libvirt/boot/${iso_file} \
--network=bridge=virbr0,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/guest-gentoo.qcow2,size=40,bus=virtio,format=qcow2

exit 0
