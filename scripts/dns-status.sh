#!/bin/sh

cat > "$HOME/tmp/resolv.conf" << EOF
search lan
nameserver 192.168.10.10
nameserver 192.168.10.1
EOF

systemd-resolve --status
resolvectl status

echo stub vs uplink
# Global
#        Protocols: LLMNR=resolve -mDNS -DNSOverTLS DNSSEC=no/unsupported
# resolv.conf mode: stub



if [ "$OS" = "Fedora Linux" ]; then
  # echo dnf -y install dnsmasq
  # Uncomment the DNSStubListener line in resolved.conf
  sudo sed -i 's/#DNSStubListener=/DNSStubListener=/' /etc/systemd/resolved.conf

  # Add the DNSStubListener=yes line after the uncommented line
  # sudo sed -i '/DNSStubListener=/a DNSStubListener=yes' /etc/systemd/resolved.conf

  # Restart the systemd-resolved service
  sudo systemctl restart systemd-resolved.service
  cat /etc/systemd/resolved.conf
  # sudo systemctl disable systemd-resolved.service
  # sudo systemctl stop systemd-resolved.service
  #
  sudo rm /etc/resolv.conf
  sudo cp "$HOME/tmp/resolv.conf" /etc/resolv.conf
  # sudo chattr +i /etc/resolv.conf
  # echo /etc/resolv.conf /run/systemd/resolve/stub-resolv.conf
  # echo sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
  # $ sudo apt-get install resolvconf
  # $ sudo systemctl start resolvconf.service
  # $ sudo systemctl enable resolveconf.service
fi

exit 0

# vim: set ft=sh
