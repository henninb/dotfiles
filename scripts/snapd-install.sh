#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  yay --noconfirm --needed -S snapd
  doas systemctl enable --now snapd
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newus sys-apps/systemd
  sudo emerge --update --newus sys-apps/apparmor
  echo GRUB_CMDLINE_LINUX_DEFAULT="apparmor=1 security=apparmor" >> /etc/default/grub
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  sudo emerge --update --newus app-containers/snapd
  doas gpasswd --add "$(id -un)" adm
  doas systemctl enable --now snapd
  doas systemctl enable --now snapd.socket
  doas systemctl enable --now snapd.apparmor
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
  doas dnf install -y snapd
  doas systemctl enable --now snapd
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
else
  echo "$OS is not yet implemented."
  exit 1
fi

doas snap install hello-world
#sudo snap install sosumi

exit 0

# vim: set ft=sh:
