#!/bin/sh

if [ -x "$(command -v pacman)" ]; then
  doas pacman --noconfirm --needed -S zsh
  doas pacman --noconfirm --needed -S starship
elif [ -x "$(command -v emerge)" ]; then
  doas emerge --update --newuse zsh
  doas emerge --update --newuse starship
elif [ -x "$(command -v zypper)" ]; then
  doas zypper install -y zsh
  doas zypper install -y starship
elif [ -x "$(command -v dnf)" ]; then
  doas dnf install -y zsh
  if [ ! -x "$(command -v starship)" ]; then
    curl -O https://starship.rs/install.sh
    chmod +x install.sh
    ./install.sh -b ~/.local/bin
    rm install.sh
  fi
elif [ -x "$(command -v apt)" ]; then
  doas apt install -y zsh
  if [ ! -x "$(command -v starship)" ]; then
    curl -O https://starship.rs/install.sh
    chmod +x install.sh
    ./install.sh -b ~/.local/bin
    rm install.sh
  fi
elif [ -x "$(command -v xbps-install)" ]; then
  doas xbps-install -y zsh
  doas xbps-install -y curl
  doas xbps-install -y starship
  doas xbps-install -y unzip
  doas xbps-install -y fontconfig
elif [ -x "$(command -v eopkg)" ]; then
  doas eopkg install -y zsh
elif [ -x "$(command -v pkg)" ]; then
  doas pkg install -y zsh
  doas pkg install -y starship
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

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S zsh
  doas pacman --noconfirm --needed -S unzip
  doas pacman --noconfirm --needed -S wget
  doas pacman --noconfirm --needed -S fontconfig
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ] || [ "$OS" = "Debian GNU/Linux" ]; then
  doas apt install -y zsh
  doas apt install -y unzip
  doas apt install -y fontconfig
elif [ "$OS" = "Clear Linux OS" ]; then
  doas swupd bundle-add zsh
  doas swupd bundle-add wget
  doas swupd bundle-add fonts-basic
elif [ "$OS" = "OpenBSD" ]; then
  echo "openbsd"
elif [ "$OS" = "FreeBSD" ]; then
  doas pkg install -y coreutils
  doas pkg install -y urwfonts
elif [ "$OS" = "Fedora Linux" ]; then
  doas dnf install -y unzip
  doas dnf install -y util-linux-user
elif [ "$OS" = "Gentoo" ]; then
  doas emerge --update --newuse unzip
  doas emerge --update --newuse fontconfig
  sudo emerge --update --newuse media-fonts/urw-fonts
  doas emerge --update --newuse java-config
elif [ "$OS" = "Solus" ]; then
  doas eopkg install -y zsh
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y zsh
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y curl
  doas xbps-install -y unzip
  doas xbps-install -y fontconfig
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

if ! git clone https://github.com/zsh-users/zsh-autosuggestions.git "${HOME}/.zsh-plugins/zsh-autosuggestions"; then
  echo "failure"
fi

#git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git "${HOME}/.zsh-plugins/powerlevel10k"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${HOME}/.zsh-plugins/zsh-syntax-highlighting"

git clone https://github.com/wting/autojump.git "$HOME/.zsh-plugins/autojump"

git clone --recursive https://github.com/eendroroy/zed-zsh "$HOME/.zsh-plugins/zed-zsh"

git clone https://github.com/zsh-users/zsh-history-substring-search.git "$HOME/.zsh-plugins/zsh-history-substring-search"

git clone https://github.com/hkupty/ssh-agent.git "$HOME/.zsh-plugins/ssh-agent"

git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
$HOME/.fzf/install --key-bindings --completion --no-update-rc

# git clone https://github.com/denysdovhan/spaceship-prompt.git "${HOME}/.zsh-themes/spaceship-prompt"
# git clone https://github.com:agnoster/agnoster-zsh-theme.git "$HOME/.zsh-themes/agnoster-zsh-theme"
# git clone https://github.com/dracula/zsh.git "$HOME/.zsh-themes/dracula-zsh-theme"

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
