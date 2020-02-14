#!/bin/sh

#WINEARCH=win32 WINEPREFIX=~/.wine32 winecfg
#WINEPREFIX=~/.wine32 wine /media/henninb/Office2007WAH/setup.exe

cat > pacman.conf << 'EOF'
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF

if [ "$OS" = "Arch Linux" ]; then
  # grep "^[multilib]" /etc/pacman.conf
  # if [ $? -ne 0 ]; then
  #   cat pacman.conf | sudo tee -a /etc/pacman.conf
  #   rm -rf pacman.conf
  # fi
  # sudo pacman --noconfirm --needed -Syy
  # sudo pacman --noconfirm --needed -S wine
  yay -S multilib/wine
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y epel-release
  #sudo subscription-manager repos
  sudo yum install wine
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) ]; then
  sudo apt install -y wine64
else
  echo $OS is not yet implemented.
  exit 1
fi

exit 0
