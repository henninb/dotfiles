## does not work
```
install a backup proxmox server on the existing network
ip route add default via 192.168.10.6
ip route add 192.168.10.0/24 via 192.168.10.6
```

## make ISOs available to install
```
mv *.iso /var/lib/vz/template/iso/
systemctl restart pveproxy.service
```

## update source list
```
vi /etc/apt/sources.list.d/pve-enterprise.list
deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
```

## update source list
```
vi /etc/apt/sources.list.d# cat ceph.list
deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription
```

3 network ports
MANAGEMENT -> Switch
WAN -> CenturyLink
LAN -> Switch (VLAN10, VLAN20)


DataCenter -> Acme
Accounts Add


## clear the partition table
```
dd if=/dev/zero of=/dev/sdX bs=512 count=1
```

Datacenter -> pve -> disks -> ZFS
Create ZFS
name -> local240

Datacenter -> pve -> network
vmbr0 -> CIDR 192.168.10.4/24 -> Gateway 192.168.10.1

add a linux bridge
vmbr1 -> enp1s0f0
vmbr2 -> enp1s0f1

create vm
general
name -> pfsense
vm id -> 100
start at boot -> yes
next

OS
ISO image -> pfsense.iso
next

System
bios -> OVMF or SeaBIOS
next

Disk
Storage -> local240
Disk size -> 16gb
next

CPU
sockets -> 1
cores -> 2
next

Memory
Memory -> 4096
Minimum Memory -> 4096
next

Network
no network device
next

confirm
finish

pfsense -> hardware -> add -> network device
vmbr1 (net0) -> WAN
vmbr2 (net1) -> LAN

Datacenter -> pve -> pfsense -> Hardware
Add PCI device -> raw device -> 0000:04:000 -> raw device
Add PCI device -> raw device -> 0000:03:000 -> raw device
Add PCI device -> raw device -> 0000:05:000 -> raw device

100 pfsense
101 debian-docker
102 debian-webserver
