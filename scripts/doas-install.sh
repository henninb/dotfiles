#!/bin/sh


cat << EOF > "$HOME/tmp/doas.conf"
permit nopass henninb as root
EOF

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S doas
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse doas
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ] || [ "$OS" = "Debian GNU/Linux" ]; then
  sudo apt install -y doas
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y opendoas
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y doas
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper addrepo https://download.opensuse.org/repositories/security/openSUSE_Tumbleweed/security.repo
  sudo zypper refresh
  sudo zypper install -y opendoas
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y doas
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
else
  echo "$OS is not yet implemented."
  exit 1
fi

if [ "$OS" = "FreeBSD" ]; then
  sudo mv -v "$HOME/tmp/doas.conf" /usr/local/etc/doas.conf
  sudo chown root:wheel /usr/local/etc/doas.conf
  sudo chmod 600 /usr/local/etc/doas.conf
else
  sudo mv -v "$HOME/tmp/doas.conf" /etc/doas.conf
  sudo chown root:root /etc/doas.conf
  sudo chmod 600 /etc/doas.conf
fi

exit 0
# vim: set ft=sh:
