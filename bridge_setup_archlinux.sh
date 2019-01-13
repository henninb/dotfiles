#!/bin/sh

cat > uplink.network <<'EOF'
[Match]
Name=enp9s0

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

if [ "$OS" = "Arch Linux" ]; then
  sudo mv br0.netdev /etc/systemd/network/br0.netdev
  sudo mv uplink.network /etc/systemd/network/uplink.network
  sudo mv br0.network /etc/systemd/network/br0.network

  sudo systemctl disable netctl
  sudo systemctl enable systemd-networkd
  sudo systemctl disable dhcpcd.service
else
  rm br0.netdev uplink.network br0.network
  echo $OS not implemented.
  exit 1
fi

echo sudo route del -net 192.168.100.0 gw 0.0.0.0 netmask 255.255.255.0 dev enp9s0
echo networkctl

exit 0
