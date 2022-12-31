#!/bin/sh

if [ $# -gt 1 ]; then
    echo "Usage: $0 [remove y/n]"
    exit 1
fi

remove=$1
iso_file="FreeBSD-13.0-RELEASE-amd64-dvd1.iso"
guest_name="freebsd"

virsh shutdown "guest-$guest_name"
virsh destroy "guest-$guest_name"
virsh undefine "guest-$guest_name"

sudo mkdir -p /var/lib/libvirt/images/
sudo mkdir -p /var/lib/libvirt/boot
sudo chown -R qemu:qemu /var/lib/libvirt/boot
sudo chown -R qemu:qemu /var/lib/libvirt/images
sudo rm "/var/lib/libvirt/images/guest-${guest_name}.qcow2"

if [ "$remove" = "y" ]; then
  echo "remove only"
  exit 1
fi

if [ ! -f "/var/lib/libvirt/boot/${iso_file}" ]; then
  scp -p "pi:/home/pi/shared/template/iso/${iso_file}" .
  sudo mv "${iso_file}" /var/lib/libvirt/boot/
fi

echo "osinfo-query os"
echo "disk bus can be virtio i.e. vda, or scsi i.e. sda"

exec virt-install \
--connect qemu:///system \
--virt-type=kvm \
--name "guest-$guest_name" \
--memory=4096,maxmemory=4096 \
--vcpus=1,maxvcpus=2 \
--osinfo detect=on,require=off \
--virt-type=kvm \
--hvm \
--boot uefi \
--cdrom=/var/lib/libvirt/boot/${iso_file} \
--network=bridge=virbr0,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/guest-$guest_name.qcow2,size=32,bus=scsi,format=qcow2

exit 0
