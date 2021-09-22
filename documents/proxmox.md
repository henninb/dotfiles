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

## update proxmox - comment out the enterprise repo
```
vi /etc/apt/sources.list.d/pve-enterprise.list
```
