#!/bin/sh

cat > "$HOME/tmp/hosts" <<'EOF'
[pfsense]
192.168.10.1

[ddwrt]
192.168.10.3

[proxmox]
192.168.10.4

[debian]
192.168.10.10

[gentoo]
192.168.10.103

[local]
localhost

[archlinux]
102.168.10.107
EOF

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "archlinux"
elif [ "$OS" = "Gentoo" ]; then
  echo "gentoo"
  doas emerge --update --newuse ansible
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo "debian"
elif [ "$OS" = "Void" ]; then
  echo "void"
elif [ "$OS" = "FreeBSD" ]; then
  echo "freebsd"
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo opensuse
elif [ "$OS" = "Fedora Linux" ]; then
  echo "fedora"
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
else
  echo "$OS is not yet implemented."
  exit 1
fi

doas usermod -aG ansible "$(id -un)"
sudo mkdir -p /etc/ansible
sudo mv "$HOME/tmp/hosts" /etc/ansible/hosts

exit 0

# vim: set ft=sh:
