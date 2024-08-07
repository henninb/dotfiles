#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "archlinux"
elif [ "$OS" = "Gentoo" ]; then
  doas emerge --update --newuse rsync
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo "debian"
elif [ "$OS" = "Void" ]; then
  echo "void"
elif [ "$OS" = "FreeBSD" ]; then
  echo "freebsd"
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y ca-certificates-cacert
  sudo /sbin/update-ca-certificates
elif [ "$OS" = "Fedora Linux" ]; then
  echo "fedora"
elif [ "$OS" = "Slackware" ]; then
  echo Slackware
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
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
echo 'nix-env -i mongodb'
echo 'nix-env -i starship'
echo 'nix-env -i newsboat'

git checkout $HOME/.bash_profile  $HOME/.zshenv

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  nix-env -i librewolf
  nix-env -i ventoy
elif [ "$OS" = "Gentoo" ]; then
  nix-env -i android-studio-stable
  nix-env -i syncthingtray
  nix-env -i ventoy
  nix-env -i burpsuite
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  nix-env -i android-studio-stable
  nix-env -i librewolf
  # nix-env -i brave
  nix-env -i dbeaver
  # nix-env -i neovim
  # nix-env -i dunst
  # nix-env -i keepassxc
  # nix-env -i gqrx
  nix-env -i ventoy
  nix-env -i codium
elif [ "$OS" = "Void" ]; then
  nix-env -i android-studio-stable
  # nix-env -i brave
  nix-env -i librewolf
  nix-env -i codium
  nix-env -i dbeaver
  nix-env -i yubikey-manager-qt
elif [ "$OS" = "FreeBSD" ]; then
  echo "freebsd"
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  # nix-env -i brave
  nix-env -i librewolf
  nix-env -i ventoy
  nix-env -i volumeicon
  nix-env -i wmname
  # nix-env -i browsh
  nix-env -i codium
  nix-env -i CopyQ
  # nix-shell -p copyq
elif [ "$OS" = "Fedora Linux" ]; then
  nix-env -i android-studio-stable
  # nix-env -i brave
  nix-env -i librewolf
  nix-env -i codium
  nix-env -i ventoy
  nix-env -i xdo
  nix-env -i dzen2
elif [ "$OS" = "Slackware" ]; then
  nix-env -i librewolf 
  nix-env -i keepassxc
  nix-env -i conky
  nix-env -i dunst
  nix-env -i flameshot
  nix-env -i volumeicon
  nix-env -i feh
  nix-env -i numlockx
  nix-env -i xdo
  nix-env -i xdotool
  nix-env -i dzen2
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
else
  echo "$OS is not yet implemented."
  exit 1
fi

nix-shell -p nix-info --run "nix-info -m"

nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update
nix-env -iA nixgl.auto.nixGLDefault
echo nixGL blender

exit 0

# example
# https://github.com/endofunky/nix-config/tree/4b0332656f835f6b2fcbcfa27b4ea60576f0b7e3

# vim: set ft=sh:
