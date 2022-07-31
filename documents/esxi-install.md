# esxi

- install syslinux
- format usb with 1 FAT32 partition
    fdisk /dev/sdc
    [d] delete any previous partitions
    [n] [p] new primary partition whole disk
    [t] [c] for FAT32
    [a] make active
    [w] write changes
- format
    /sbin/mkfs.vfat -F 32 -n ESXI /dev/sdc1
- copy bootloader
    /usr/bin/syslinux /dev/sdc1
    cat /usr/share/syslinux/mbr.bin > /dev/sdc
    cat /usr/lib/syslinux/bios/mbr.bin > /dev/sdc
- copy ESXi binaries to USB
    mkdir esxicd usbdisk
    mount /dev/sdc1 usbdisk
    mount -o loop VMware-VMvisor-Installer-7.0b-16324942.x86_64.iso esxicd
    mount -o loop ../VMware-VMvisor-Installer-7.0U3-18644231.x86_64.iso esxicd
    cp -r esxicd/* usbdisk
- edit boot configuration
    mv usbdisk/isolinux.cfg usbdisk/syslinux.cfg
    sed -i -e 's/boot.cfg/boot.cfg -p 1/' usbdisk/syslinux.cfg
- cleanup
    umount usbdisk
    umount esxicd
    rmdir usbdisk esxicd


$ lsusb
Bus 001 Device 008: ID 0781:5151 SanDisk Corp. Cruzer Micro Flash Drive

$ sudo qemu-system-x86_64 -m 512 -enable-kvm -usb -device usb-host,hostbus=1,hostaddr=8



[root@arcolinux scratch]# mkfs.vfat -F 32 -n USB /dev/sdc1
mkfs.fat 4.2 (2021-01-31)
[root@arcolinux scratch]# syslinux /dev/sdc1
Hidden (2048) does not match sectors (62)
Hidden (2048) does not match sectors (62)
Hidden (2048) does not match sectors (62)
Hidden (2048) does not match sectors (62)


