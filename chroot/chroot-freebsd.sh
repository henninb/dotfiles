#!/bin/sh

# fetch ftp://ftp.freebsd.org/pub/FreeBSD/releases/amd64/13.0-RELEASE/base.txz
curl -o base.txz ftp://ftp.freebsd.org/pub/FreeBSD/releases/amd64/13.0-RELEASE/base.txz

exit 1
tar -C /path/to/chroot -zxvf base.txz

mount -t devfs dev /path/to/chroot/dev
mount -t procfs proc /path/to/chroot/proc
mount -t fdescfs fdesc /path/to/chroot/dev/fd

cp /etc/resolv.conf /path/to/chroot/etc/

chroot /path/to/chroot /bin/sh

passwd

exit 0
