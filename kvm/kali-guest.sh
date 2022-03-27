#!/bin/sh

iso_file=kali-linux-2022.1-installer-amd64.iso
virsh shutdown guest-kali
virsh undefine guest-kali

sudo mkdir -p /var/lib/libvirt/images/
sudo mkdir -p /var/lib/libvirt/boot/

if [ ! -f "/var/lib/libvirt/boot/${iso_file}" ]; then
  scp "pi:/home/pi/shared/template/iso/${iso_file}" .
  sudo mv "${iso_file}" /var/lib/libvirt/boot/
fi

# sudo fallocate -l 10G /var/kvm/images/guest-kali.img
# sudo chmod 777 /var/kvm/images/guest-kali.img

sudo virt-install \
--virt-type=kvm \
--name guest-kali \
--memory=4096,maxmemory=4096 \
--vcpus=1,maxvcpus=2 \
--os-variant=debian9 \
--virt-type=kvm \
--hvm \
--cdrom=/var/lib/libvirt/boot/${iso_file} \
--network=bridge=virbr0,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/guest-kali.qcow2,size=40,bus=virtio,format=qcow2

exit 0
