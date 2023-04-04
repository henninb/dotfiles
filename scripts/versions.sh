#!/bin/sh

date=$(date '+%Y-%m-%d')

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "sudo pacman --noconfirm --needed -S"
elif [ "$OS" = "Gentoo" ]; then
  echo "sudo emerge --update --newuse"
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo "sudo apt install"
elif [ "$OS" = "Void" ]; then
  echo "sudo xbps-install -y"
elif [ "$OS" = "FreeBSD" ]; then
  echo "sudo pkg install -y"
elif [ "$OS" = "OpenBSD" ]; then
  echo "OpenBSD"
elif [ "$OS" = "Solus" ]; then
  "sudo eopkg install -y"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo "sudo zypper install -y"
elif [ "$OS" = "Fedora Linux" ]; then
  echo "sudo dnf install -y"
elif [ "$OS" = "Clear Linux OS" ]; then
  "sudo swupd bundle-add"
elif [ "$OS" = "Darwin" ]; then
  echo "brew install"
else
  echo "$OS is not yet implemented."
  exit 1
fi

javac --version | tee -a "$HOME/tmp/version-$date-$$.dat"
node --version | tee -a "$HOME/tmp/version-$date-$$.dat"
npm --version | tee -a "$HOME/tmp/version-$date-$$.dat"
nvim --version | head -1 | tee -a "$HOME/tmp/version-$date-$$.dat"
xmonad --version | tee -a "$HOME/tmp/version-$date-$$.dat"
stack --version | tee -a "$HOME/tmp/version-$date-$$.dat"
alacritty --version | tee -a "$HOME/tmp/version-$date-$$.dat"
netlify --version | tee -a "$HOME/tmp/version-$date-$$.dat"
dunst --version | tee -a "$HOME/tmp/version-$date-$$.dat"
kitty --version | tee -a "$HOME/tmp/version-$date-$$.dat"
nix-env --version | tee -a "$HOME/tmp/version-$date-$$.dat"
starship --version | head -1 | tee -a "$HOME/tmp/version-$date-$$.dat"
arduino-cli version | tee -a "$HOME/tmp/version-$date-$$.dat"
llvm-config --version | tee -a "$HOME/tmp/version-$date-$$.dat"
pip --version | tee -a "$HOME/tmp/version-$date-$$.dat"
stack exec -- ghc --version | tee -a "$HOME/tmp/version-$date-$$.dat"
conky -version | head -1 | tee -a "$HOME/tmp/version-$date-$$.dat"
emacs --version | head -1 | tee -a "$HOME/tmp/version-$date-$$.dat"
fish --version | head -1 | tee -a "$HOME/tmp/version-$date-$$.dat"
go version | tee -a "$HOME/tmp/version-$date-$$.dat"
lightdm --version | tee -a "$HOME/tmp/version-$date-$$.dat"
dzen2 -v | head -1 | tee -a "$HOME/tmp/version-$date-$$.dat"
keepassxc --version | tee -a "$HOME/tmp/version-$date-$$.dat"
brave-browser --version | tee -a "$HOME/tmp/version-$date-$$.dat"
xdotool version | tee -a "$HOME/tmp/version-$date-$$.dat"


neovim_release=$(curl -s https://api.github.com/repos/neovim/neovim/tags | jq -r '.[0].name')
xmonad_release=$(curl -s https://api.github.com/repos/xmonad/xmonad/tags | jq -r '.[0].name')
starship_release=$(curl -s https://api.github.com/repos/starship/starship/tags | jq -r '.[0].name')
emacs_release=$(curl -s https://api.github.com/repos/emacs-mirror/emacs/tags | jq -r '.[0].name')
conky_release=$(curl -s https://api.github.com/repos/brndnmtthws/conky/tags | jq -r '.[0].name')

exit 0
