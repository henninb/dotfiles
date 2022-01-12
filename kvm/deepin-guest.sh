#!/bin/sh

iso_file=deepin-desktop-community-20.3-amd64.iso
virsh shutdown guest-deepin
virsh undefine guest-deepin

sudo mkdir -p /var/lib/libvirt/images/
sudo mkdir -p /var/lib/libvirt/boot/

if [ ! -f "/var/lib/libvirt/boot/${iso_file}" ]; then
  scp "pi:/home/pi/downloads/${iso_file}" .
  sudo mv "${iso_file}" /var/lib/libvirt/boot/
fi

echo osinfo-query os | grep debian9
# sudo fallocate -l 10G /var/kvm/images/guest-deepin.img
# sudo chmod 777 /var/kvm/images/guest-deepin.img

sudo virt-install \
--virt-type=kvm \
--name guest-deepin \
--memory=4096,maxmemory=4096 \
--vcpus=1,maxvcpus=2 \
--os-type=debian11 \
--virt-type=kvm \
--hvm \
--cdrom=/var/lib/libvirt/boot/${iso_file} \
--network=bridge=virbr0,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/guest-deepin.qcow2,size=64,bus=virtio,format=qcow2

exit 0
