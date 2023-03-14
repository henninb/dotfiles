#!/bin/sh

npm install -g neovim
python3 -m pip install --user --upgrade pynvim
gem install neovim
ghcup install hls
npm install -g tree-sitter-cli

echo :LspInstall ccls

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S clang
  sudo pacman --noconfirm --needed -S llvm
  sudo pacman --noconfirm --needed -S llvm-libs
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse clang
  sudo emerge --update --newuse cmake
  sudo emerge --update --newuse llvm
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y luarocks
  sudo apt install -y cmake
  sudo apt install -y llvm
  sudo apt install -y clang
  sudo apt install -y libxml2-dev
  sudo apt install -y llvm-dev
  sudo apt install -y libclang-dev
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y cmake
  sudo xbps-install -y llvm
  sudo xbps-install -y clang
  sudo xbps-install -y xtool
  sudo xbps-install -y libxml2-devel
  sudo xbps-install -y clang-tools-extra
elif [ "$OS" = "FreeBSD" ]; then
  echo "freebsd"
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y cmake
  sudo zypper install -y llvm
  sudo zypper install -y clang
  sudo zypper install -y gcc-c++
  sudo zypper install -y libxml2-devel
  sudo zypper install -y llvm-devel
  sudo zypper install -y clang-devel
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y llvm-devel
  sudo dnf install -y llvm-libs
  sudo dnf install cmake
  sudo dnf groupinstall "Development Tools" "Development Libraries"
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
