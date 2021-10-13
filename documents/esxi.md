# esxi

- install syslinux
- format usb with 1 FAT32 partition
    fdisk /dev/sdg
    [d] delete any previous partitions
    [n] [p] new primary partition whole disk
    [t] [c] for FAT32
    [a] make active
    [w] write changes
- format
    /sbin/mkfs.vfat -F 32 -n ESXI /dev/sdg1
- copy bootloader
    /usr/bin/syslinux /dev/sdg1
    cat /usr/share/syslinux/mbr.bin > /dev/sdg
    cat /usr/lib/syslinux/bios/mbr.bin > /dev/sdg
- copy ESXi binaries to USB
    mkdir esxicd usbdisk
    mount /dev/sdg1 usbdisk
    mount -o loop VMware-VMvisor-Installer-7.0b-16324942.x86_64.iso esxicd
    cp -r esxicd/* usbdisk
- edit boot configuration
    mv usbdisk/isolinux.cfg usbdisk/syslinux.cfg
    sed -i -e 's/boot.cfg/boot.cfg -p 1/' usbdisk/syslinux.cfg
- cleanup
    umount usbdisk
    umount esxicd
    rmdir usbdisk esxicd

