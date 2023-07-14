#!/bin/sh

npm install -g neovim
npm install -g tree-sitter-cli
python3 -m pip install --user --upgrade pynvim
gem install neovim
ghcup install hls

echo :LspInstall ccls

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S clang
  doas pacman --noconfirm --needed -S llvm
  doas pacman --noconfirm --needed -S llvm-libs
elif [ "$OS" = "Gentoo" ]; then
  doas emerge --update --newuse clang
  doas emerge --update --newuse cmake
  doas emerge --update --newuse llvm
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y luarocks
  doas apt install -y cmake
  doas apt install -y llvm
  doas apt install -y clang
  doas apt install -y libxml2-dev
  doas apt install -y llvm-dev
  doas apt install -y libclang-dev
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y cmake
  doas xbps-install -y llvm
  doas xbps-install -y clang
  doas xbps-install -y xtool
  doas xbps-install -y libxml2-devel
  doas xbps-install -y clang-tools-extra
elif [ "$OS" = "FreeBSD" ]; then
  doas pkg install -y cmake
  doas pkg install -y llvm
  doas pkg install -y libxml2
elif [ "$OS" = "Alpine Linux" ]; then
  doas apk add gcc
  doas apk add cmake
  doas apk add python3
  doas apk add  cmake make clang build-base llvm-static llvm-dev clang-static clang-dev
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y cmake
  doas zypper install -y llvm
  doas zypper install -y clang
  doas zypper install -y gcc-c++
  doas zypper install -y libxml2-devel
  doas zypper install -y llvm-devel
  doas zypper install -y clang-devel
elif [ "$OS" = "Fedora Linux" ]; then
  doas dnf install -y llvm-devel
  doas dnf install -y llvm-libs
  doas dnf install cmake
  doas dnf groupinstall "Development Tools" "Development Libraries"
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  brew install llvm
  brew install cmake
else
  echo "$OS is not yet implemented."
  exit 1
fi

echo nix-shell -p cmake
echo nix-shell -p llvm
echo nix-shell -p clang
echo nix-shell -p libclang
echo nix-shell -p libxml2

exit 0
# vim: set ft=sh:
