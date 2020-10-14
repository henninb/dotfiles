#!/bin/sh

if [ "$OS" = "Linux Mint" ]; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove -y
elif [ "$OS" = "Ubuntu" ]; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove -y
elif [ "$OS" = "Darwin" ]; then
  softwareupdate -l
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt update 2>&1 | tee -a update.log.$$
  sudo apt upgrade -y 2>&1 | tee -a update.log.$$
  sudo apt autoremove -y 2>&1 | tee -a update.log.$$
elif [ "$OS" = "Solus" ]; then
  sudo eopkg remove -y libreoffice-common
  sudo eopkg remove -y thunderbird
#  sudo eopkg remove -y lightdm
  sudo eopkg upgrade -y
elif [ "$OS" = "void" ]; then
  sudo xbps-install -u xbps
  sudo xbps-install -Suy
elif [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -Syu 2>&1 | tee -a update.log.$$
  yay -Syu
elif [ "$OS" = "Arch Linux" ]; then
  du -sh /var/cache/pacman/pkg
  sudo pacman --noconfirm --needed -Syu 2>&1 | tee -a update.log.$$
  echo sudo pacman -Scc
  sudo paccache -r 2>&1 | tee -a update.log.$$
  sudo paccache -rk 1 2>&1 | tee -a update.log.$$
  sudo paccache -ruk0 2>&1 | tee -a update.log.$$
  yay -Syu 2>&1 | tee -a update.log.$$
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  # sudo zypper dist-upgrade
  # sudo zypper refersh
  sudo zypper dup
  sudo zypper ref
  sudo zypper update
elif [ "$OS" = "Gentoo" ]; then
  sudo eselect news read
  if ! sudo emerge --sync 2>&1 | tee -a update.log.$$; then
    sudo emerge-webrsync 2>&1 | tee -a update.log.$$
  fi
  sudo emerge -uN portage
  sudo emerge -uDUf --keep-going --with-bdeps=y @world 2>&1 | tee -a update.log.$$
  sudo emerge -uDU --keep-going --with-bdeps=y @world 2>&1 | tee -a update.log.$$
  #sudo emerge --update --newuse --deep @world 2>&1 | tee -a update.log.$$
  sudo emerge -uDN --keep-going --with-bdeps=y @world 2>&1 | tee -a update.log.$$
  sudo emerge --depclean 2>&1 | tee -a update.log.$$
  echo sudo emerge @preserved-rebuild
  echo eselect editor list
  echo emerge --depclean -p
  echo sudo etc-update
elif [ "$OS" = "CentOS Linux" ]; then
  if [ "$OS_VER" = "8" ]; then
    sudo dnf update -y
    sudo dnf upgrade -y
  else
    sudo yum update -y
    sudo yum upgrade -y
  fi
elif [ "$OS" = "Fedora" ]; then
    sudo dnf update -y
    sudo dnf upgrade -y
elif [ "$OS" = "FreeBSD" ]; then
  #sudo freebsd-update fetch
  #sudo freebsd-update install
  sudo freebsd-update fetch install 2>&1 | tee -a update.log.$$
  sudo pkg upgrade 2>&1 | tee -a update.log.$$
  echo sudo pkg clean
  echo sudo pkg update -f
  echo sudo pkg bootstrap
else
  echo "$OS is not yet implemented."
  exit 1
fi

flatpak update --user -y

exit 0
