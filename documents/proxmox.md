# proxmox

## passthrough
```
$ vi /etc/default/grub
GRUB_CMDLINE_LINUX="iommu=soft"
iommu=soft
$ update-grub
$ reboot
```

## passthrough
```
$ sudo vi /etc/default/grub
GRUB_CMDLINE_LINUX="intel_iommu=on"
$ sudo update-grub
$ sudo reboot
```

## update proxmox - comment out the enterprise repo and add the community
```
vi /etc/apt/sources.list.d/pve-enterprise.list
deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
```


## commands
```
qm set 101 --onboot 1
qm set 101 --onboot 0
qm list
qm start 101
qm shutdown 101
```

## list templates on storage
```
pveam list local
```

## add template to storage
```
pveam download local-500 debian-10-turnkey-core_16.1-1_amd64.tar.gz
```

## backup a guest
```
vzdump 101 --dumpdir /root --mode stop
scp /root/vzdump-qemu-106-2022_11_30-21_56_04.vma root@0.0.0.0:/root/
qmrestore vzdump-qemu-101-2024_03_29-18_06_10.vma 101 --storage local-240
```

## backup (close) a guest
```
qm clone 101 200 --name "pfsense-backup" --targetstorage local-500-backup
```

## load an iso
/var/lib/vz/template/iso/

scp pfSense-CE-2.7.0-DEVELOPMENT-amd64-latest.iso proxmox:/var/lib/vz/template/iso/

ln -s /path/to/iso-image.iso /var/lib/vz/template/iso/iso-name.iso
ln -s /local-2tb/debian-12.8.0-amd64-netinst.iso /var/lib/vz/template/iso/debian-12.8.0-amd64-netinst.iso
ln -s /local-2tb/Win10_22H2_English_x64v1.iso /var/lib/vz/template/iso/Win10_22H2_English_x64v1.iso
ln -s /local-2tb/virtio-win-0.1.248.iso /var/lib/vz/template/iso/virtio-win-0.1.248.iso
ln -s /local-2tb/kali-linux-2024.3-installer-amd64.iso /var/lib/vz/template/iso/kali-linux-2024.3-installer-amd64.iso
ln -s /local-2tb/gparted-live-1.6.0-10-amd64.iso /var/lib/vz/template/iso/gparted-live-1.6.0-10-amd64.iso

systemctl restart pveproxy.service

## version
pveversion

## upgrade
pve7to8

## NICs without drivers - using PCI passthrough
NetXtreme BCM5720 Gigabit Ethernet PCIe

## network setup proxmox
cat /etc/network/interfaces

iface en0 inet manual

auto vmbr0.100
iface vmbr0.100 inet static
  address 192.168.100.10/24
  gateway 192.168.100.1

auto vmbr0
iface vmbr0 inet static
  bridge-ports en0
  bridge-stp off
  bridge-fd 0
  bridge-vlan-aware yes
  brigee-vids 2-4092


## import an existing zfs disk pool on a new server
zpool import
zpool import local-500 -f
datacenter -> storage -> add -> ZFS -> id -> local-500
qm rescan


## ipod usb port
```
qm set 106 -usb0 host=05ac:1301
```

# remove nag screen
sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
