#!/bin/sh

iso_file=FreeBSD-13.0-RELEASE-amd64-dvd1.iso

sudo virsh shutdown guest-freebsd
sudo virsh undefine guest-freebsd

if [ ! -f "/var/lib/libvirt/boot/FreeBSD-13.0-RELEASE-amd64-dvd1.iso" ]; then
  scp pi:/home/pi/downloads/FreeBSD-13.0-RELEASE-amd64-dvd1.iso .
  sudo mv FreeBSD-13.0-RELEASE-amd64-dvd1.iso /var/lib/libvirt/boot/
fi

sudo pacman --noconfirm --needed -S virt-viewer

# execute with exec
sudo virt-install \
--virt-type=kvm \
--name guest-freebsd \
--memory=1024,maxmemory=2048 \
--vcpus=1,maxvcpus=2 \
--os-variant=freebsd10.0 \
--virt-type=kvm \
--hvm \
--cdrom=/var/lib/libvirt/boot/FreeBSD-13.0-RELEASE-amd64-dvd1.iso \
--network=bridge=br0,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/guest-freebsd.qcow2,size=40,bus=virtio,format=qcow2

exit 0
