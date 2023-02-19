#!/bin/sh

npm install -g neovim
python3 -m pip install --user --upgrade pynvim
gem install neovim
ghcup install hls
npm install -g tree-sitter-cli

echo :LspInstall ccls
echo sudo pacman --noconfirm --needed -S llvm
echo sudo dnf install -y llvm-devel
echo sudo dnf install -y llvm-libs
echo sudo dnf install cmake
echo sudo dnf groupinstall "Development Tools" "Development Libraries"


if command -v xbps-install; then
  sudo xbps-install -y cmake
  sudo xbps-install -y llvm
  sudo xbps-install -y clang
  sudo xbps-install -y xtool
  sudo xbps-install -y libxml2-devel
  sudo xbps-install -y clang-tools-extra
fi


sudo apt install -y luarocks

if command -v emerge; then
  sudo emerge --update --newuse clang
fi

if command -v brew; then
  brew install llvm
  brew install cmake
fi

exit 0
