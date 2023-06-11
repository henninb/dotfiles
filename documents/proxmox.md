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

## backup (close) a guest
```
qm clone 101 200 --name "pfsense-backup" --targetstorage local-500-backup
```

## load an iso
scp ~/Downloads/arcolinuxb-hyprland-v23.05.04-x86_64.iso  pi:/home/pi/shared/template/iso/
/var/lib/vz/template/iso/

systemctl restart pveproxy.service
