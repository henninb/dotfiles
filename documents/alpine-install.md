doas cfdisk /dev/sde
doas mkfs.ext4 -j -b 4096 /dev/sde3

sudo mkdir -p /mnt/alpine
sudo mount /dev/sde3 /mnt/alpine
sudo mkdir -p /mnt/alpine/boot/efi
sudo mount /dev/sde1 /mnt/alpine/boot/efi
sudo cd /mnt/alpine


boot into alpine standard
answer the questions up to the disk
answer none 3x
mount /dev/sde3 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sde1 /mnt/boot/efi
setup-disk -m /mnt




wget https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/x86_64/alpine-minirootfs-3.18.2-x86_64.tar.gz

doas tar -xzvf alpine-minirootfs-3.18.2-x86_64.tar.gz -C /mnt/alpine
doas cp /etc/resolv.conf /mnt/alpine/etc/

sudo mount --rbind /dev /mnt/alpine/dev
sudo mount --make-rslave /mnt/alpine/dev
sudo mount -t proc /proc /mnt/alpine/proc
sudo mount --rbind /sys /mnt/alpine/sys
sudo mount --make-rslave /mnt/alpine/sys
sudo mount --rbind /tmp /mnt/alpine/tmp
sudo cp /etc/resolv.conf /mnt/alpine/etc/resolv.conf


sudo mount --bind /dev /mnt/alpine/dev
sudo mount --bind /proc /mnt/alpine/proc
sudo mount --bind /sys /mnt/alpine/sys
chroot /mnt/alpine /bin/sh


apk add grub-efi efibootmgr
mount -t efivarfs efivarfs /sys/firmware/efi/efivars
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=alpine
apt add alpine-base
apk add liunx-lts
mkinitfs 6.1.37-0-lts -o /boot/initramfs-6.1.37-0-lts
mkinitfs 6.1.38-0-lts -o /boot/initramfs-6.1.38-0-lts
grub-mkconfig -o /boot/grub/grub.cfg

adduser -g henninb henninb

apk add openssh-server

apk add linux-firmware linux-lts grub grub-efi efibootmgr

I had to add modules=sd-mod,usb-storage,ext4 quiet rootfstype=ext4 to the /etc/default/grub:

