doas cfdisk /dev/sdc
doas mkfs.ext4 -j -b 4096 /dev/sdc3

mkdir -p /mnt/alpine
mount /dev/sdc3 /mnt/alpine
mkdir -p /mnt/alpine/boot/efi
mount /dev/sdc1 /mnt/alpine/boot/efi
cd /mnt/alpine

wget https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/x86_64/alpine-minirootfs-3.18.2-x86_64.tar.gz

doas tar -xzvf alpine-minirootfs-3.18.2-x86_64.tar.gz -C /mnt/alpine
doas cp /etc/resolv.conf /mnt/alpine/etc/


sudo mount --bind /dev /mnt/alpine/dev
sudo mount --bind /proc /mnt/alpine/proc
sudo mount --bind /sys /mnt/alpine/sys
chroot /mnt/alpine /bin/sh


apk add grub-efi efibootmgr
mount -t efivarfs efivarfs /sys/firmware/efi/efivars
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=alpine
grub-mkconfig -o /boot/grub/grub.cfg

adduser -g henninb henninb
