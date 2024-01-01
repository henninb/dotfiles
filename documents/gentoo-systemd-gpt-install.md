# gentoo install - last executed on 2023-12-30
download archlinux

https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation

## boot
```
boot archlinux
```

## network configures automatically on gentoo for VirtualBox and most baremetal
```
ip addr show
```

## set root password
```
passwd root
```

## remote ssh login from remote
```
ssh root@192.168.10.103
```

## partition the drive as show below (use gpt)
```
parted /dev/sda mklabel gpt
parted /dev/sda mkpart primary 1 1024
parted /dev/sda mkpart primary 1024 100%
```

## make the partitions (use gpt)
```
mkfs.fat -F32 /dev/sda1
mkfs.ext4 -j -b 4096 /dev/sda2
```

## mount the partitions (use gpt)
```
mkdir -p /mnt/gentoo
mount /dev/sda2 /mnt/gentoo
mkdir -p /mnt/gentoo/boot/efi
mount /dev/sda1 /mnt/gentoo/boot/efi
cd /mnt/gentoo
```

## download stage3
```
https://mirror.bytemark.co.uk/gentoo/releases/amd64/autobuilds/
curl -Os 'https://mirror.bytemark.co.uk/gentoo/releases/amd64/autobuilds/20230115T170214Z/stage3-amd64-desktop-systemd-20230115T170214Z.tar.xz'
```

## extract stage3 and be sure to verify success
```
tar xvJpf stage3-*.tar.xz --xattrs --numeric-owner
rm stage3-amd64-desktop-systemd-*.tar.xz
```

## generate fstab
```
genfstab -U /mnt/gentoo >> /mnt/gentoo/etc/fstab
```

## erase root and login with systemd
```
cat /mnt/gentoo/etc/shadow | grep root
sed -i -e 's/^root:\*/root:/' /mnt/gentoo/etc/shadow
systemd-nspawn -bD /mnt/gentoo
```

## login (no password)
```
root
```

## set locale systemd
```
cat << EOF >> /etc/locale.gen
en_US.UTF-8 UTF-8
EOF
```

## set locale
```
locale-gen
```

## systemd activities
```
hostnamectl set-hostname "gentoo"
echo "127.0.0.1 gentoo.lan gentoo" >> /etc/hosts

timedatectl list-timezones
timedatectl set-timezone America/Chicago
timedatectl set-ntp yes
localectl list-locales
localectl set-locale LANG=en_US.utf8
localectl set-keymap us
```

## logout of systemd
```
poweroff
```

## use flags
```
cat << EOF >> /mnt/gentoo/etc/portage/make.conf
MAKEOPTS="-j4"
ACCEPT_LICENSE="*"
EOF
```

## copy the resolv config
```
cp -L /etc/resolv.conf /mnt/gentoo/etc/
```

## mount the devices
```
mount -t proc none /mnt/gentoo/proc
mount --rbind /dev /mnt/gentoo/dev
mount --rbind /sys /mnt/gentoo/sys
modprobe efivarfs
```

## configure the chroot (enter commands individually)
```
chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) $PS1"
```

## user maintenence
```
useradd -m -G users henninb
usermod -aG wheel henninb
passwd henninb
passwd root
```

## run the webrsync (clock needs to be accurate and DNS needs to be functional)
```
emerge-webrsync
eselect news read
```

## install packages
```
emerge sys-kernel/gentoo-sources linux-firmware sys-kernel/genkernel cronie mlocate rsyslog sys-boot/grub:2 sudo dhcpcd dhcp gentoo-kernel-bin doas
etc-update
```

## edit sudoers
```
cat << EOF >> /etc/sudoers
%wheel ALL=(ALL:ALL) NOPASSWD: ALL
EOF
```

## edit doas.conf
```
cat << EOF >> /etc/doas.conf
permit nopass henninb as root
EOF

chmod 600 /etc/doas.conf
```

## update system settings
```
systemctl enable rsyslog
systemctl enable cronie
systemctl enable sshd
systemctl enable dhcpcd
```

# build and install the kernel (will take 42 min)
```
eselect kernel set 1
eselect kernel list
genkernel all
genkernel --menuconfig all
genkernel --menuconfig --kernel-config=/usr/src/linux/.config-main --install all
genkernel --kernel-config=/usr/src/linux/.config-main --install all

# grep CONFIG_SCSI_VIRTIO /usr/src/linux/.config
# kernel change only needed if running on a virtual

General Setup
└─> File systems
└─> Virtio Filesystem
CONFIG_VIRTIO_FS=m

General Setup
└─> Device Drivers
└─> Block devices
└─> Virtio block driver
CONFIG_VIRTIO_BLK=y

General Setup
└─> Device Drivers
└─> SCSI device support
└─> SCSI low-level drivers
└─> virtio-scsi support (towards the bottom)
CONFIG_SCSI_VIRTIO=m

General Setup
└─> Device Drivers
└─> Virtio drivers
└─> PCI support
└─> PCI driver for virtio devices
CONFIG_VIRTIO_PCI=y

General Setup
└─> Device Drivers
└─> Network device support
└─> Virtio network driver
CONFIG_VIRTIO_NET=y
CONFIG_NET_FAILOVER=m
```

## verify the kernel
```
ls /boot/vmlinuz* /boot/initramfs*
```

## grub install (with gpt)
```
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=gentoo-new
grub-mkconfig -o /boot/grub/grub.cfg
````

## reboot system
```
exit
reboot
```
