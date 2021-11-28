#!/bin/sh

if [ "$OS" = "Linux Mint" ]; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove -y
  sudo apt install -y curl
elif [ "$OS" = "Ubuntu" ]; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove -y
  sudo apt install -y curl
elif [ "$OS" = "Darwin" ]; then
  softwareupdate -l
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt update 2>&1 | tee -a update-$$.log
  sudo apt upgrade -y 2>&1 | tee -a update-$$.log
  sudo apt autoremove -y 2>&1 | tee -a update-$$.log
elif [ "$OS" = "Solus" ]; then
  sudo eopkg remove -y libreoffice-common
  sudo eopkg remove -y thunderbird
  sudo eopkg upgrade -y
elif [ "$OS" = "void" ]; then
  sudo xbps-remove -yO
  sudo xbps-remove -yo
  sudo vkpurge rm all
  sudo xbps-install -u xbps
  sudo xbps-install -Suy
elif [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -Syu 2>&1 | tee -a update-$$.log
  yay -Syu
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  du -sh /var/cache/pacman/pkg
  sudo pacman --noconfirm --needed -Syu 2>&1 | tee -a update-$$.log
  echo sudo pacman -Scc
  sudo paccache -r 2>&1 | tee -a update-$$.log
  sudo paccache -rk 1 2>&1 | tee -a update-$$.log
  sudo paccache -ruk0 2>&1 | tee -a update-$$.log
  yay -Syu 2>&1 | tee -a update-$$.log
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  # sudo zypper dist-upgrade
  # sudo zypper refersh
  sudo zypper dup
  sudo zypper ref
  sudo zypper update
elif [ "$OS" = "Gentoo" ]; then
  sudo eselect news read
  if ! sudo emerge --sync 2>&1 | tee -a update-$$.log; then
    sudo emerge-webrsync 2>&1 | tee -a update-$$.log
  fi
  sudo emerge -uN portage
  sudo emerge -uDUf --keep-going --with-bdeps=y @world 2>&1 | tee -a update-$$.log
  sudo emerge -uDU --keep-going --with-bdeps=y @world 2>&1 | tee -a update-$$.log
  #sudo emerge --update --newuse --deep @world 2>&1 | tee -a update-$$.log
  sudo emerge -uDN --keep-going --with-bdeps=y @world 2>&1 | tee -a update-$$.log
  sudo emerge --depclean 2>&1 | tee -a update-$$.log
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
  sudo freebsd-update fetch install 2>&1 | tee -a update-$$.log
  sudo pkg upgrade 2>&1 | tee -a update-$$.log
  echo sudo pkg clean
  echo sudo pkg update -f
  echo sudo pkg bootstrap
else
  echo "$OS is not yet implemented."
  exit 1
fi

#golang_ver=$(curl -s 'https://golang.org/VERSION?m=text')
golang_ver=$(curl -s 'https://go.dev/VERSION?m=text')

if [ ! -x "$(command -v go)" ]; then
  echo "golang needs to be installed"
else
  if echo "$(go version)" | grep -q "$golang_ver"; then
  #if grep -q "$golang_ver" <<< "$(go version)"; then
    echo "golang is already up to date"
  else
    echo "updating golang"
  fi
  go version
fi

if [ ! -x "$(command -v stack)" ]; then
  echo "stack is being installed"
  curl -sSL 'https://get.haskellstack.org' | sh
  stack --version
else
  stack update
  stack upgrade
  echo "stack version"
  stack --version
fi

if [ ! -x "$(command -v flatpak)" ]; then
  echo "flatpak needs to be installed."
else
  flatpak update --user -y
fi

if [ ! -x "$(command -v nvm)" ]; then
  echo "nvm needs to be installed."
else
  nvm install --lts
  echo "npm version"
  npm --version
fi

if [ ! -x "$(command -v rustup)" ]; then
  curl --proto '=https' --tlsv1.2 -sSf 'https://sh.rustup.rs' > rustup-init
  chmod 755 rustup-init
  ./rustup-init -y --no-modify-path
else
  rustc --version
  rustup update
  rustc --version
fi

exit 0
