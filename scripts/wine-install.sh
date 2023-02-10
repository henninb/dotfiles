#!/bin/sh

#WINEARCH=win32 WINEPREFIX=~/.wine32 winecfg
#WINEPREFIX=~/.wine32 wine /media/henninb/Office2007WAH/setup.exe

cat > "$HOME/tmp/pacman.conf" << 'EOF'
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  grep "^[multilib]" /etc/pacman.conf
  if [ $? -ne 0 ]; then
    echo "not found"
    #cat pacman.conf | sudo tee -a /etc/pacman.conf
  fi
  # sudo pacman --noconfirm --needed -Syy
  # sudo pacman --noconfirm --needed -S wine
  # yay -S multilib/wine
  sudo pacman --noconfirm --needed -S wine
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse wine
elif [ "$OS" = "Void" ]; then
  echo Void
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y wine
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  sudo apt install -y wine64
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh
