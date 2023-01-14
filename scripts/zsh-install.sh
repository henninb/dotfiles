#!/bin/sh

if [ -x "$(command -v pacman)" ]; then
  sudo pacman --noconfirm --needed -S zsh
  sudo pacman --noconfirm --needed -S starship
elif [ -x "$(command -v emerge)" ]; then
  sudo emerge --update --newuse zsh
  sudo emerge --update --newuse starship
elif [ -x "$(command -v apt)" ]; then
  sudo apt install -y zsh
  curl -O https://starship.rs/install.sh
  chmod +x install.sh
  ./install.sh -b ~/.local/bin
  rm install.sh
elif [ -x "$(command -v xbps-install)" ]; then
  sudo xbps-install -y zsh
  sudo xbps-install -y curl
elif [ -x "$(command -v eopkg)" ]; then
  sudo eopkg install -y zsh
elif [ -x "$(command -v pkg)" ]; then
  sudo pkg install -y zsh
  sudo pkg install -y starship
elif [ -x "$(command -v dnf)" ]; then
  sudo dnf install -y zsh
  curl -O https://starship.rs/install.sh
  chmod +x install.sh
  ./install.sh -b ~/.local/bin
  rm install.sh
elif [ -x "$(command -v brew)" ]; then
  brew install zsh
else
  echo "$OS is not yet implemented."
  exit 1
fi

if [ -x "$(command -v zsh)" ]; then
  echo zsh is not installed.
fi

if ! command -v starship; then
  curl -fsSL https://starship.rs/install.sh
  mv install.sh "$HOME/tmp"
  chmod +x "$HOME/tmp/install.sh"
  cd "$HOME/tmp"
  ./install.sh
fi

if [ "$OS" = "CentOS Linux" ]; then
  if [ "$OS_VER" = "8" ]; then
    sudo dnf install -y zsh
  else
    sudo yum install -y zsh
  fi
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S zsh
  sudo pacman --noconfirm --needed -S unzip
  sudo pacman --noconfirm --needed -S wget
  sudo pacman --noconfirm --needed -S fontconfig
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ] || [ "$OS" = "Debian GNU/Linux" ]; then
  sudo apt install -y zsh
  sudo apt install -y unzip
  sudo apt install -y fontconfig
elif [ "$OS" = "Clear Linux OS" ]; then
  sudo swupd bundle-add zsh
  sudo swupd bundle-add wget
  sudo swupd bundle-add fonts-basic
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y coreutils
  sudo pkg install -y urwfonts
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y unzip
  sudo dnf install -y util-linux-user
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse unzip
  sudo emerge --update --newuse fontconfig
  sudo emerge --update --newuse media-fonts/urw-fonts
  sudo emerge --update --newuse java-config
elif [ "$OS" = "Solus" ]; then
  sudo eopkg install -y zsh
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y zsh
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y curl
  sudo xbps-install -y unzip
  sudo xbps-install -y fontconfig
elif [ "$OS" = "Darwin" ]; then
  brew install coreutils
  brew install fontconfig
  for f in $(compaudit);do sudo chown "$(whoami):admin" "$f";done;
  for f in $(compaudit);do sudo chmod 755 "$f";done;
else
  echo "$OS is not yet implemented."
  exit 1
fi

echo curl -fsSL https://starship.rs/install.sh | bash

if ! git clone https://github.com/zsh-users/zsh-autosuggestions.git "${HOME}/plugins/zsh-autosuggestions"; then
  echo "failure"
fi

#git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git "${HOME}/plugins/powerlevel10k"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${HOME}/plugins/zsh-syntax-highlighting"

git clone https://github.com/wting/autojump.git "$HOME/plugins/autojump"

git clone --recursive https://github.com/eendroroy/zed-zsh "$HOME/plugins/zed-zsh"

git clone https://github.com/zsh-users/zsh-history-substring-search.git "$HOME/plugins/zsh-history-substring-search"

git clone https://github.com/hkupty/ssh-agent.git "$HOME/plugins/ssh-agent"

git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
$HOME/.fzf/install --key-bindings --completion --no-update-rc

# git clone https://github.com/denysdovhan/spaceship-prompt.git "${HOME}/themes/spaceship-prompt"
# git clone https://github.com:agnoster/agnoster-zsh-theme.git "$HOME/themes/agnoster-zsh-theme"
# git clone https://github.com/dracula/zsh.git "$HOME/themes/dracula-zsh-theme"

[ -s "/usr/bin/zsh" ] && sudo usermod -s /usr/bin/zsh "$(whoami)"
[ -s "/usr/bin/zsh" ] && sudo chsh -s /usr/bin/zsh "$(whoami)"

[ -s "/bin/zsh" ] && sudo usermod -s /bin/zsh "$(whoami)"
[ -s "/bin/zsh" ] && sudo chsh -s /bin/zsh "$(whoami)"

[ -s "/usr/local/bin/zsh" ] && sudo usermod -s /usr/local/bin/zsh "$(whoami)"
[ -s "/usr/local/bin/zsh" ] && sudo chsh -s /usr/local/bin/zsh "$(whoami)"

echo sudo vipw #fixes passwd file for freebsd

#for i in $fpath; do echo $i; ls -l $i | egrep -i "(async|pure)"; done

exit 0

# vim: set ft=sh:
