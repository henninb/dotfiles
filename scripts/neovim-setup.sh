#!/bin/sh

npm install -g neovim
python3 -m pip install --user --upgrade pynvim
gem install neovim
ghcup install hls
npm install -g tree-sitter-cli

echo :LspInstall ccls

if command -v pacman; then
  sudo pacman --noconfirm --needed -S llvm
fi

if command -v dnf; then
  sudo dnf install -y llvm-devel
  sudo dnf install -y llvm-libs
  sudo dnf install cmake
  sudo dnf groupinstall "Development Tools" "Development Libraries"
fi

if command -v zypper; then
  sudo zypper install -y cmake
  sudo zypper install -y llvm
  sudo zypper install -y clang
  sudo zypper install -y gcc-c++
  sudo zypper install -y libxml2-devel
  sudo zypper install -y llvm-devel
  sudo zypper install -y clang-devel
fi

if command -v xbps-install; then
  sudo xbps-install -y cmake
  sudo xbps-install -y llvm
  sudo xbps-install -y clang
  sudo xbps-install -y xtool
  sudo xbps-install -y libxml2-devel
  sudo xbps-install -y clang-tools-extra
fi

if command -v apt; then
  sudo apt install -y luarocks
fi

if command -v emerge; then
  sudo emerge --update --newuse clang
fi

if command -v brew; then
  brew install llvm
  brew install cmake
fi

exit 0
