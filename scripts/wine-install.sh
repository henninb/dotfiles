#!/bin/sh

#WINEARCH=win32 WINEPREFIX=~/.wine32 winecfg
#WINEPREFIX=~/.wine32 wine /media/henninb/Office2007WAH/setup.exe

cat > "$HOME/tmp/pacman.conf" << 'EOF'
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "sudo pacman --noconfirm --needed -S"
  grep "^[multilib]" /etc/pacman.conf
  if [ $? -ne 0 ]; then
    echo "not found"
    #cat pacman.conf | sudo tee -a /etc/pacman.conf
  fi
  sudo pacman --noconfirm --needed -S wine
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse wine
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y wine64
elif [ "$OS" = "Void" ]; then
  echo "sudo xbps-install -y"
elif [ "$OS" = "FreeBSD" ]; then
  echo "sudo pkg install -y"
elif [ "$OS" = "OpenBSD" ]; then
  echo "OpenBSD"
elif [ "$OS" = "Solus" ]; then
  "sudo eopkg install -y"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo "sudo zypper install -y"
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y wine
elif [ "$OS" = "Clear Linux OS" ]; then
  "sudo swupd bundle-add"
elif [ "$OS" = "Darwin" ]; then
  echo "brew install"
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
