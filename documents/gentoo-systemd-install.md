# gentoo install - last executed on 7/13/2022
download minimal
download arch

https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation

## boot
```
boot > gentoo
```

## network configures automatically on gentoo for VirtualBox and most baremetal
```
systemctl start sshd
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
cfdisk /dev/vda
```

## disk layout
```
/dev/sda1	ext2	(bootloader)	1GB
/dev/sda2	ext4	Rest of the disk	Root partition
```

## make the partitions
```
mkfs.ext2 -T small /dev/sda1
mkfs.ext4 -j -T small /dev/sda2

mkfs.ext2 -T small /dev/vda1
mkfs.ext4 -j -T small /dev/vda2

mkfs.ext2 -T small /dev/sdb1
mkfs.ext4 -j -T small /dev/sdb2
```

## mounting
```
mkdir -p /mnt/gentoo
mount /dev/sda2 /mnt/gentoo
mount /dev/vda2 /mnt/gentoo
mount /dev/sdb2 /mnt/gentoo
cd /mnt/gentoo
```

## download stage3
```
curl -Os 'https://mirror.bytemark.co.uk/gentoo/releases/amd64/autobuilds/20220710T170538Z/stage3-amd64-desktop-systemd-20220710T170538Z.tar.xz'
```

## extract stage3 and be sure to verify success
```
tar xvJpf stage3-*.tar.xz --xattrs --numeric-owner
```

## erase root and login with systemd
```
cat /mnt/gentoo/etc/shadow | grep root
sed -i -e 's/^root:\*/root:/' /mnt/gentoo/etc/shadow
systemd-nspawn -bD /mnt/gentoo
```

## set locale
```
cat << EOF >> /etc/locale.gen
en_US.UTF-8 UTF-8
EOF
locale-gen
localectl list-locales
localectl set-locale LANG=en_US.utf8
localectl set-keymap us
```

hostnamectl set-hostname "gentood"
echo "127.0.0.1 gentood.localdomain gentood" >> /etc/hosts

timedatectl list-timezones | grep Chic
timedatectl set-timezone America/Chicago
timedatectl set-ntp yes
poweroff

## use flags
```
cat << EOF >> /mnt/gentoo/etc/portage/make.conf
MAKEOPTS="-j2"
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

#mount -t proc /proc /mnt/gentoo/proc
#mount --rbind /sys /mnt/gentoo/sys
#mount --rbind /dev /mnt/gentoo/dev
#mount --make-rslave /mnt/gentoo/sys
#mount --make-rslave /mnt/gentoo/dev
```

## configure the chroot
```
chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) $PS1"
```

## set the mirror list (need to fix?)
```
mirrorselect -i -o >> /etc/portage/make.conf
#mkdir -p /mnt/etc/portage/repos.conf
#cp -v /mnt/usr/share/portage/config/repos.conf /mnt/etc/portage/repos.conf/gentoo.conf
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
mount /dev/vda1 /boot
mount /dev/sdb1 /boot
```

## run the webrsync (clock needs to be accurate and DNS needs to be functional)
```
emerge-webrsync
eselect news read
emerge vim
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

## install packages
```
emerge gentoo-sources linux-firmware genkernel-next cronie mlocate rsyslog sys-boot/grub:2
emerge sys-kernel/gentoo-sources sys-kernel/genkernel sys-process/cronie net-misc/netifrc app-admin/sysklogd net-misc/dhcpcd sudo sys-boot/grub:2
etc-update
```

## edit sudoers
```
vi /etc/sudoers
```

## update system settings
```
systemctl enable rsyslog
systemctl enable cronie
systemctl enable sshd
#rc-update add sysklogd default
#rc-update add cronie default
#rc-update add dhcpcd default
#rc-update add sshd default
```

## network setup (enp1s0, eth0)
```
cat << EOF > /etc/systemd/network/50-dhcp_eth0.network
[Match]
Name=eth0

[Network]
DHCP=yes
EOF
```


ln -snf /run/systemd/resolv.conf /etc/resolv.conf
systemctl enable systemd-resolved.service


vi /etc/genkernel.conf
UDEV="yes"
MAKEOPTS="-j4"

genkernel --menuconfig all

# will take a long time (42 min)
```
eselect kernel list
eselect kernel set 1
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
echo 'GRUB_CMDLINE_LINUX="init=/usr/lib/systemd/systemd"' >> /etc/default/grub
grub-install /dev/sda
grub-install /dev/vda
grub-install /dev/sdb
grub-mkconfig -o /boot/grub/grub.cfg
reboot
```
