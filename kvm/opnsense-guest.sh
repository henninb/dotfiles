#!/bin/sh

iso_file=OPNsense-21.7.1-OpenSSL-dvd-amd64.iso

virsh shutdown guest-opnsense
virsh undefine guest-opnsense

sudo mkdir -p /var/lib/libvirt/images/
sudo mkdir -p /var/lib/libvirt/boot/
sudo rm -rf /var/lib/libvirt/images/guest-opnsense.qcow2

if [ ! -f "/var/lib/libvirt/boot/${iso_file}" ]; then
  scp "pi:/home/pi/shared/template/iso/${iso_file}" .
  sudo mv "${iso_file}" /var/lib/libvirt/boot/
fi

sudo virt-install \
--virt-type=kvm \
--name guest-opnsense \
--memory=2048,maxmemory=2048 \
--vcpus=1,maxvcpus=2 \
--os-variant=freebsd10.0 \
--virt-type=kvm \
--hvm \
--cdrom=/var/lib/libvirt/boot/${iso_file} \
--network=bridge=virbr0,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/guest-opnsense.qcow2,size=40,bus=virtio,format=qcow2

exit 0
