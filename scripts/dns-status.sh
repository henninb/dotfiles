#!/bin/sh

cat > "$HOME/tmp/resolv.conf" << EOF
search lan
nameserver 192.168.10.10
nameserver 192.168.10.1
EOF

systemd-resolve --status

# Global
#        Protocols: LLMNR=resolve -mDNS -DNSOverTLS DNSSEC=no/unsupported
# resolv.conf mode: stub



if [ "$OS" = "Fedora Linux" ]; then
  sudo systemctl disable systemd-resolved.service
  sudo systemctl stop systemd-resolved.service

  sudo rm /etc/resolv.conf
  sudo cp "$HOME/tmp/resolv.conf" /etc/resolv.conf
  sudo chattr +i /etc/resolv.conf
  echo /etc/resolv.conf /run/systemd/resolve/stub-resolv.conf
fi

exit 0

# vim: set ft=sh
