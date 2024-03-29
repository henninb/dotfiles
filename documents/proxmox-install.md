3 network ports
MANAGEMENT -> Switch
WAN -> CenturyLink
LAN -> Switch (VLAN10, VLAN20)


DataCenter -> Acme
Accounts Add


Datacenter -> pve -> disks -> ZFS
Create ZFS
label

Datacenter -> pve -> network
vmbr0 -> CIDR 192.168.10.4/24 -> Gateway 192.168.10.1

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
Disk size -> 10gb
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

Datacenter -> pve -> pfsense -> Hardware
Add PCI device -> raw device -> 0000:04:000 -> raw device
Add PCI device -> raw device -> 0000:03:000 -> raw device
Add PCI device -> raw device -> 0000:05:000 -> raw device

100 pfsense
101 debian-docker
102 debian-webserver
