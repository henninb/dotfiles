#!/bin/sh

mkdir -p "$HOME/tmp"

if [ "$OS" = "Linux Mint" ]; then
  sudo apt update | tee -a "$HOME/tmp/update-$$.log"
  sudo apt upgrade -y | tee -a "$HOME/tmp/update-$$.log"
  sudo apt autoremove -y | tee -a "$HOME/tmp/update-$$.log"
  sudo apt install -y curl
elif [ "$OS" = "Debian GNU/Linux" ]; then
  sudo apt update | tee -a "$HOME/tmp/update-$$.log"
  sudo apt upgrade -y | tee -a "$HOME/tmp/update-$$.log"
  sudo apt autoremove -y | tee -a "$HOME/tmp/update-$$.log"
elif [ "$OS" = "Ubuntu" ]; then
  sudo apt update | tee -a "$HOME/tmp/update-$$.log"
  sudo apt upgrade -y | tee -a "$HOME/tmp/update-$$.log"
  sudo apt autoremove -y | tee -a "$HOME/tmp/update-$$.log"
  sudo apt install -y curl
elif [ "$OS" = "Darwin" ]; then
  softwareupdate -l | tee -a "$HOME/tmp/update-$$.log"
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt update 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo apt upgrade -y 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo apt autoremove -y 2>&1 | tee -a "$HOME/tmp/update-$$.log"
elif [ "$OS" = "Solus" ]; then
  sudo eopkg upgrade -y | tee -a "$HOME/tmp/update-$$.log"
elif [ "$OS" = "void" ]; then
  sudo xbps-remove -yO | tee -a "$HOME/tmp/update-$$.log"
  sudo xbps-remove -yo | tee -a "$HOME/tmp/update-$$.log"
  sudo vkpurge rm all | tee -a "$HOME/tmp/update-$$.log"
  sudo xbps-install -u xbps | tee -a "$HOME/tmp/update-$$.log"
  sudo xbps-install -Suy | tee -a "$HOME/tmp/update-$$.log"
elif [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -Syu 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  yay -Syu | tee -a "$HOME/tmp/update-$$.log"
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  du -sh /var/cache/pacman/pkg
  #sudo pacman -S archlinux-keyring #invalid or corrupted package (PGP signature)
  sudo pacman --noconfirm --needed -S archlinux-keyring
  sudo pacman --noconfirm --needed -Syu 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  echo sudo pacman -Scc
  sudo paccache -r 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo paccache -rk 1 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo paccache -ruk0 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  echo sudo pacman --noconfirm -S linux
  sudo mkinitcpio -p linux
  yay --noconfirm --needed -Syu 2>&1 | tee -a "$HOME/tmp/update-$$.log"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  # sudo zypper dist-upgrade
  # sudo zypper refersh
  sudo zypper dup
  sudo zypper ref
  sudo zypper update
elif [ "$OS" = "Gentoo" ]; then
  sudo eselect news read
  if ! sudo emerge --sync 2>&1 | tee -a "$HOME/tmp/update-$$.log"; then
    sudo emerge-webrsync 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  fi
  sudo emerge -uN portage 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo emerge -uDUNf --keep-going --with-bdeps=y @world 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo emerge -uDUN --keep-going --with-bdeps=y @world 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo emerge --depclean 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo revdep-rebuild
  sudo eselect kernel set 1
  uname=$(uname -srm | cut -d' ' -f2 | cut -d- -f1)
  eselect=$(eselect kernel list | tail -1 | cut -d- -f2)
  if [ ! "${eselect}" = "${uname}" ]; then
    echo "complie the kernel '$eselect' as it is newer than '$uname'"
    sudo genkernel all
  fi
  sudo emerge @preserved-rebuild
  echo eselect editor list
  echo eselect kernel list
  echo eselect python list
  echo eselect java list
  echo emerge --depclean -p
  echo sudo etc-update
  echo revdep-rebuild
  echo sudo emerge --update --newuse --deep --changed-use --keep-going @world
elif [ "$OS" = "CentOS Linux" ]; then
  if [ "$OS_VER" = "8" ]; then
    sudo dnf update -y | tee -a "$HOME/tmp/update-$$.log"
    sudo dnf upgrade -y | tee -a "$HOME/tmp/update-$$.log"
  else
    sudo yum update -y | tee -a "$HOME/tmp/update-$$.log"
    sudo yum upgrade -y | tee -a "$HOME/tmp/update-$$.log"
  fi
elif [ "$OS" = "Fedora Linux" ]; then
    sudo dnf update -y | tee -a "$HOME/tmp/update-$$.log"
    sudo dnf upgrade -y | tee -a "$HOME/tmp/update-$$.log"
elif [ "$OS" = "FreeBSD" ]; then
  #sudo freebsd-update fetch
  #sudo freebsd-update install
  sudo freebsd-update fetch install 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo pkg upgrade 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  echo sudo pkg clean
  echo sudo pkg update -f
  echo sudo pkg bootstrap
else
  echo "$OS is not yet implemented."
  exit 1
fi

#golang_ver=$(curl -s 'https://golang.org/VERSION?m=text')
golang_ver=$(curl -s 'https://go.dev/VERSION?m=text')

if ! command -v go; then
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

if ! command -v stack; then
  echo "stack is being installed"
  curl -sSL 'https://get.haskellstack.org' | sh
  stack --version
else
  stack update
  stack upgrade
  echo "stack version"
  stack --version
fi

if ! command -v nvm; then
  echo "nvm needs to be installed."
else
  nvm install --lts
  echo "npm version"
  npm --version
fi

if ! command -v rustup; then
  curl --proto '=https' --tlsv1.2 -sSf 'https://sh.rustup.rs' > "$HOME/tmp/rustup-init"
  chmod 755 "$HOME/tmp/rustup-init"
  cd "$HOME/tmp" || exit
  ./rustup-init -y --no-modify-path
  cd - || exit
else
  rustc --version
  rustup update
  rustc --version
fi

if ! command -v flatpak; then
  echo "flatpak needs to be installed."
else
  flatpak update --user -y
fi


if ! command -v nix-env; then
  echo "nix needs to be installed."
else
  # nix-env -u
  nix-env -u '.*'
fi

exit 0

# vim: set ft=sh:
