#!/bin/sh

device=enp3s0

cat > "$HOME/tmp/bridged-network.xml" <<EOF
<network>
    <name>br0-bridged-network</name>
    <forward mode="bridge" />
    <bridge name="br0" />
</network>
EOF

if [ $# -ne 1 ]; then
    echo "Usage: $0 <device>"
    echo "Example: $0 enp3s0"
    exit 1
fi

device=$1

# if [ "$OS" = "Arch Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  # sudo ip addr del "your ip" dev dummy0
  echo "using network manager cli"
  doas nmcli -f bridge con delete br0
  doas nmcli connection add ifname br0 type bridge con-name br0
  doas nmcli con modify br0 bridge.stp no
  doas ip addr flush dev "$device"
  doas nmcli connection add type ethernet con-name br0-slave-1 ifname "$device" master br0
  doas nmcli connection up br0
  doas dhclient br0

  virsh net-define "$HOME/tmp/bridged-network.xml"
  virsh net-start br0-bridged-network
  virsh net-autostart br0-bridged-network
  virsh net-list

  ### dynamically creating a bridge
  # sudo ip link set "$device" up
  # sudo ip addr flush dev "$device"
  # sudo brctl addbr br0
  # sudo brctl addif br0 "$device"
  # sudo ip link set dev br0 up
  # sudo dhclient br0

  echo status
  nmcli connection show
  bridge link show dev enp3s0
  nmcli dev status
# else
  # rm -rf br0.netdev uplink.network br0.network
  # echo "$OS not implemented."
  # exit 1
# fi

echo sudo ip link set dev br0 down
echo sudo brctl delbr br0
echo sudo ip link set "$device" up

ip addr show dev br0
ip addr show dev "$device"

exit 0

# vim: set ft=sh:
