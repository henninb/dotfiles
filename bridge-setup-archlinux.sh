#!/bin/sh

device=enp3s0

cat > uplink.network <<'EOF'
[Match]
Name=$device

[Network]
Bridge=br0
EOF

cat > br0.netdev <<'EOF'
[NetDev]
Name=br0
Kind=bridge
EOF

cat > br0.network <<'EOF'
[Match]
Name=br0

[Network]
DHCP=yes
EOF

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo brctl addbr br0
  sudo brctl addif br0 "$device"
  sudo ip link set dev br0 up
  # sudo mv br0.netdev /etc/systemd/network/br0.netdev
  # sudo mv uplink.network /etc/systemd/network/uplink.network
  # sudo mv br0.network /etc/systemd/network/br0.network

  # sudo systemctl disable netctl
  # sudo systemctl enable systemd-networkd
  # sudo systemctl disable dhcpcd.service
else
  rm br0.netdev uplink.network br0.network
  echo "$OS not implemented."
  exit 1
fi

# echo sudo route del -net 192.168.10.0 gw 0.0.0.0 netmask 255.255.255.0 dev $device
# echo networkctl

echo sudo ip link set dev br0 down
echo sudo brctl delbr br0

exit 0
