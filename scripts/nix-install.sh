#!/bin/sh

if command -v pacman; then
  echo "archlinux"
elif command -v emerge; then
  echo "gentoo"
  sudo emerge --update --newuse rsync
elif command -v zypper; then
  echo "tumbleweed"
elif command -v apt; then
  echo "debian"
elif command -v xbps-install; then
  echo "void"
  sudo eopkg install -y rsync
elif command -v eopkg; then
  echo "solus"
elif command -v dnf; then
  echo "fedora"
elif command -v brew; then
  echo "macos"
else
  echo "$OS is not yet implemented."
  exit 1
fi
sudo rm -rf /etc/nix /nix /root/.nix-profile /root/.nix-defexpr /root/.nix-channels $HOME/.nix-profile $HOME/.nix-defexpr $HOME/.nix-channels

curl -v 'https://diagnostic.opendns.com'
#sh <(curl -s -L https://nixos.org/nix/install) --daemon
curl -L https://nixos.org/nix/install | sh

nix-env -q --available mongodb
echo 'nix-env -q --available mongodb'

echo 'nix-env -i notepadqq'
echo 'nix-env -i dbeaver'
echo 'nix-env -i mongodb'
echo 'nix-env -i starship'
echo 'nix-env -i newsboat'

if [ "$OS" = "Ubuntu" ]; then
  nix-env -i lazygit
  nix-env -i librewolf
  nix-env -i brave
  nix-env -i dbeaver
  # nix-env -i neovim
  nix-env -i dunst
  nix-env -i keepassxc
  nix-env -i gqrx
  nix-env -i ventoy-bin
  nix-env -i codium
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  nix-env -i librewolf
  nix-env -i ventoy-bin
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y ca-certificates-cacert
  sudo /sbin/update-ca-certificates
  nix-env -i brave
  nix-env -i librewolf
  nix-env -i volumeicon
  nix-env -i wmname
  nix-env -i browsh
  nix-env -i codium
  nix-env -i CopyQ
  nix-shell -p copyq
elif [ "$OS" = "Fedora Linux" ]; then
  nix-env -i librewolf
  nix-env -i codium
  nix-env -i xdo
  nix-env -i dzen2
else
  echo 'OS not configured'
fi

exit 0

# example
# https://github.com/endofunky/nix-config/tree/4b0332656f835f6b2fcbcfa27b4ea60576f0b7e3

# vim: set ft=sh
