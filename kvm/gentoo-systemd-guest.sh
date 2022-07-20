#!/bin/sh

iso_file="archlinux-x86_64.iso"
guest_name="gentoo"

virsh shutdown "guest-$guest_name"
virsh destroy "guest-$guest_name"
virsh undefine "guest-$guest_name"

sudo mkdir -p /var/lib/libvirt/images/
sudo mkdir -p /var/lib/libvirt/boot
sudo rm "/var/lib/libvirt/images/guest-${guest_name}.qcow2"

if [ ! -f "/var/lib/libvirt/boot/${iso_file}" ]; then
  scp "pi:/home/pi/shared/template/iso/${iso_file}" .
  sudo mv "${iso_file}" /var/lib/libvirt/boot/
fi

echo "osinfo-query os"
echo "disk bus can be virtio i.e. vda, or scsi i.e. sda"

exec sudo virt-install \
--virt-type=kvm \
--name "guest-$guest_name" \
--memory=8192,maxmemory=8192 \
--vcpus=2,maxvcpus=2 \
--virt-type=kvm \
--hvm \
--cdrom=/var/lib/libvirt/boot/${iso_file} \
--network=bridge=virbr0,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/guest-$guest_name.qcow2,size=40,bus=scsi,format=qcow2

exit 0
