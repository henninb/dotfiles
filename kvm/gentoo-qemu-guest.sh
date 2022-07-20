#!/bin/sh

if [ $# -gt 1 ]; then
    echo "Usage: $0 [remove y/n]"
    exit 1
fi

remove=$1
iso=install-amd64-minimal-20190630T214502Z.iso¬
sudo chmod 777 "$iso"
sudo fallocate -l 10G /var/kvm/images/guest-gentoo.img
sudo chmod 777 /var/kvm/images/guest-gentoo.img

exec qemu-system-x86_64 -enable-kvm \
        -cpu host \
        -drive file=/var/kvm/images/guest-gentoo.img,if=virtio \
        -net nic -net user,hostname=guest-gentoo \
        -m 256M \
        -monitor stdio \
        -name guest-gentoo \
        -boot d -cdrom "$iso"

exit 0
