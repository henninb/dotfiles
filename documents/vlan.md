# vlan
sudo vconfig add enp3s0 10

sudo ip addr add 192.168.10.41/24 dev enp3s0.10

settins for TL-SG108E
Port	PVID Speed
Port 1	3000 1000 - proxmox lan
Port 2	10   100 - proxmox admin and virtuals
Port 3	10   100 - vlan10 wifi
Port 4	10   1000 - to office
Port 5	1
Port 6	1
Port 7	20   1000 - vlan20 wifi
Port 8	1



VLAN ID	MemberPorts	TaggedPorts	UntaggedPorts
1	    8		                8
10		1-4	         1	        2-4
20		1,5-7	     1,5-6	    7
3000	6		                6
