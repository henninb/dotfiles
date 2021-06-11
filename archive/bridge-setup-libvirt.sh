#!/bin/sh

sudo brctl delbr virbr1
sudo ip link set virbr1 down
sudo brctl delbr virbr1
sudo ip link set virbr2 down
sudo brctl delbr virbr2

echo sudo sudo virsh net-edit vagrant-libvirt

exit 0

# <domain name='example.com' localOnly='yes'/>

# <dhcp>
#   <range start='192.168.122.100' end='192.168.122.254'/>
#   <host mac='52:54:00:6c:3c:01' name='vm1' ip='192.168.122.11'/>
#   <host mac='52:54:00:6c:3c:02' name='vm2' ip='192.168.122.12'/>
#   <host mac='52:54:00:6c:3c:03' name='vm3' ip='192.168.122.12'/>
# </dhcp>

# <interface type='direct'>
#   <mac address='52:54:00:1f:dd:c4'/>
#   <source dev='eth0' mode='bridge'/>
#   <model type='virtio'/>
#   <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
# </interface>
