#!/bin/sh

if [ $# -gt 1 ]; then
    echo "Usage: $0 [remove y/n]"
    exit 1
fi

remove=$1
iso_file="Fedora-Workstation-Live-x86_64-37-1.7.iso"
guest_name="fedora"

virsh shutdown "guest-$guest_name"
virsh destroy "guest-$guest_name"
virsh undefine "guest-$guest_name"

sudo mkdir -p /var/lib/libvirt/boot
sudo mkdir -p /var/lib/libvirt/images
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
--memory=8192,maxmemory=8192 \
--vcpus=1,maxvcpus=2 \
--virt-type=kvm \
--hvm \
--boot uefi \
--cdrom=/var/lib/libvirt/boot/${iso_file} \
--network=bridge=virbr0,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/guest-$guest_name.qcow2,size=40,bus=scsi,format=qcow2

exit 0
