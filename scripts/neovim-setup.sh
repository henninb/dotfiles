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

sudo xbps-install -y cmake
sudo xbps-install -y llvm
sudo xbps-install -y clang
sudo xbps-install -y libxml2-devel


exit 0
