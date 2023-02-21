# gentoo install - last executed on 6/14/2021
download minimal

https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation

## boot
```
boot > gentoo
```

## network configures automatically on gentoo for VirtualBox and most baremetal
```
rc-service sshd start
ip addr show
```

## set root password
```
passwd root
```

## start dhcp server
```
rc-service dhcpcd start
```

## remote ssh login from remote
```
ssh root@192.168.10.103
```

## partition the drive as show below (use dos)
```
cfdisk /dev/sda
```

## disk layout
```
/dev/sda1	ext2	(bootloader)	1GB
/dev/sda2	ext4	Rest of the disk	Root partition
```

## make the partitions
```
mkfs.ext2 -T small /dev/sda1
mkfs.ext4 -j -b 4096 /dev/sda2

mkfs.ext2 -T small /dev/sdb1
mkfs.ext4 -j -b 4096 /dev/sdb2
```

## time sync
```
ntpd -q -g
```

## mounting
```
mount /dev/sda2 /mnt/gentoo
mount /dev/sdb2 /mnt/gentoo
cd /mnt/gentoo
```

## download stage3
```
#wget https://mirror.bytemark.co.uk/gentoo//releases/amd64/autobuilds/20211114T170549Z/stage3-amd64-openrc-20211114T170549Z.tar.xz
wget https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/20220710T170538Z/stage3-amd64-openrc-20220710T170538Z.tar.xz
```
## extract stage3 and be sure to verify success
```
tar xvJpf stage3-*.tar.xz --xattrs --numeric-owner
```

## use flags
```
vi /mnt/gentoo/etc/portage/make.conf
MAKEOPTS="-j2"
ACCEPT_LICENSE="*"
```

## set the mirror list
```
mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf
```


## copy the resolv config
```
cp -L /etc/resolv.conf /mnt/gentoo/etc/
```

## mount the devices
```
mount -t proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
```

## configure the chroot
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

## mount boot
```
mount /dev/sda1 /boot
mount /dev/sdb1 /boot
```

## run the webrsync (clock needs to be accurate and DNS needs to be functional)
```
emerge-webrsync
eselect news read
emerge vim dev-vcs/git
```

## setup local time zone
```
echo "US/Central" > /etc/timezone
emerge --config sys-libs/timezone-data
```

## edit fstab
```
vi /etc/fstab
```

## file content
```
/dev/sda1   /boot        ext2    defaults,noatime     0 2
/dev/sda2   /            ext4    noatime              0 1
/dev/cdrom  /mnt/cdrom   auto    noauto,user          0 0
```

## update the hostname
```
vi /etc/conf.d/hostname
```

## install packages
```
emerge sys-kernel/gentoo-sources sys-kernel/genkernel sys-process/cronie net-misc/netifrc app-admin/sysklogd net-misc/dhcpcd sudo sys-boot/grub:2
etc-update
```

## setup locale
```
vi /etc/locale.gen
en_US.UTF-8 UTF-8
locale-gen
eselect locale list
eselect locale set 4
```


## edit sudoers
```
vi /etc/sudoers
```

## update system settings
```
rc-update add sysklogd default
rc-update add cronie default
rc-update add dhcpcd default
rc-update add sshd default
```


# will take a long time (42 min)
```
cd /usr/src
ln -sfn linux-5.10.61-gentoo linux
sudo eselect kernel list
echo sudo eselect kernel set 1
genkernel all
```

## check kernel logs
```
tail -f /var/log/genkernel.log
```

## verify the kernel
ls /boot/vmlinuz* /boot/initramfs*

## grub install
```
grub-install /dev/sda
grub-install /dev/sdb
grub-mkconfig -o /boot/grub/grub.cfg
reboot
```
