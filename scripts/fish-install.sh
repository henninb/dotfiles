#!/bin/sh

cat << EOF > "$HOME/tmp/doas.conf"
permit nopass henninb as root
EOF

if [ -x "$(command -v pacman)" ]; then
  sudo pacman --noconfirm --needed -S doas
  doas pacman --noconfirm --needed -S fish
  doas pacman --noconfirm --needed -S starship
  doas pacman --noconfirm --needed -S fontconfig
  doas pacman --noconfirm --needed -S unzip
  doas pacman --noconfirm --needed -S openssh
elif [ -x "$(command -v emerge)" ]; then
  sudo emerge --update --newuse doas
  doas emerge --update --newuse fish
  doas emerge --update --newuse starship
elif [ -x "$(command -v zypper)" ]; then
  sudo zypper addrepo https://download.opensuse.org/repositories/security/openSUSE_Tumbleweed/security.repo
  sudo zypper refresh
  sudo zypper install -y opendoas
  doas zypper install -y fish
  doas zypper install -y starship
  doas zypper install -y gcc
  doas zypper install -y gcc-c++
  doas zypper install -y cmake
  doas zypper install -y fontconfig-devel
elif [ -x "$(command -v dnf)" ]; then
  sudo dnf install -y doas
  doas dnf install -y fish
  if [ ! -x "$(command -v starship)" ]; then
    curl -O https://starship.rs/install.sh
    chmod +x install.sh
    ./install.sh -b ~/.local/bin
    rm install.sh
  fi
elif [ -x "$(command -v apt)" ]; then
  sudo apt install -y curl
  sudo apt install -y doas
  doas apt install -y fish
  doas apt install -y unzip
  doas apt install -y fontconfig
  if [ ! -x "$(command -v starship)" ]; then
    curl -O https://starship.rs/install.sh
    chmod +x install.sh
    ./install.sh -b ~/.local/bin
    rm install.sh
  fi
elif [ -x "$(command -v xbps-install)" ]; then
  sudo xbps-install -y opendoas
  doas xbps-install -y fish
  doas xbps-install -y curl
  doas xbps-install -y starship
  doas xbps-install -y unzip
  doas xbps-install -y fontconfig
elif [ -x "$(command -v apk)" ]; then
  sudo apk add fish
  sudo apk add doas
  sudo apk add starship
  sudo ln -sfn /usr/bin/fish /bin/fish
elif [ -x "$(command -v eopkg)" ]; then
  sudo eopkg install -y doas
  doas eopkg install -y fish
elif [ -x "$(command -v pkg)" ]; then
  sudo pkg install -y doas
  doas pkg install -y fish
  doas pkg install -y starship
elif [ -x "$(command -v slackpkg)" ]; then
  echo Slackware
elif [ -x "$(command -v brew)" ]; then
  brew install fish
else
  echo "'$OS' is not yet implemented."
  exit 1
fi

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S fish
elif [ "$OS" = "Gentoo" ]; then
  if ! command -v fish; then
    doas emerge --update --newuse fish
  fi
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ] || [ "$OS" = "Debian GNU/Linux" ]; then
  # sudo apt install -y fish
  wget https://launchpad.net/~fish-shell/+archive/ubuntu/release-3/+files/fish_3.6.1-1~jammy_amd64.deb
  doas dpkg -i fish_3.6.1-1_jammy_amd64.deb
  rm fish_3.6.1-1_jammy_amd64.deb
  if ! grep -Fxq "/bin/fish" /etc/shells; then
    echo "/bin/fish" | sudo tee -a /etc/shells
    echo "The string /bin/fish has been added to /etc/shells"
  fi
elif [ "$OS" = "Slackware" ]; then
  # wget 'https://github.com/fish-shell/fish-shell/releases/download/3.6.1/fish-3.6.1.tar.xz' -O "$HOME/tmp/fish-3.6.1.txz"
  wget 'https://slackbuilds.org/slackbuilds/15.0/system/fish.tar.gz' -O "$HOME/tmp/fish-3.6.1.tgz"
  sudo installpkg "$HOME/tmp/fish-3.6.1.tgz"
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y xtools
  cd "$HOME/projects" || exit
  git clone git@github.com:void-linux/void-packages.git
  cd void-packages || exit
  ./xbps-src pkg fish-shell
  xi fish-shell
  if ! grep -Fxq "/bin/fish" /etc/shells; then
    echo "/bin/fish" | sudo tee -a /etc/shells
    echo "The string /bin/fish has been added to /etc/shells"
  fi
  # sudo xbps-install -y ncurses-devel
  # sudo xbps-install -y pcre2
  # sudo xbps-install -S readline-devel
  # sudo xbps-install -S libedit-devel
  # mkdir -p "$HOME/projects/github.com/fish-shell"
  # cd "$HOME/projects/github.com/fish-shell" || exit
  # git clone https://github.com/fish-shell/fish-shell.git
  # cd fish-shell || exit
  # mkdir -p build
  # cd build || exit
  # cmake ..
  # make
  # sudo make install
elif [ "$OS" = "FreeBSD" ]; then
  doas pkg install -y fish
elif [ "$OS" = "Alpine Linux" ]; then
 echo "alpine"
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y fish
  if ! grep -Fxq "/bin/fish" /etc/shells; then
    echo "/bin/fish" | sudo tee -a /etc/shells
    echo "The string /bin/fish has been added to /etc/shells"
  fi
  # echo sudo vi /etc/shells
  # echo /bin/fish
elif [ "$OS" = "Fedora Linux" ]; then
  doas dnf install -y fish
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  brew install fish
else
  echo "'$OS' is not yet implemented."
  exit 1
fi

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$HOME/.fzf/install --key-bindings --completion --no-update-rc

[ -s "/bin/fish" ] && sudo usermod -s /bin/fish "$(whoami)"
[ -s "/bin/fish" ] && sudo chsh -s /bin/fish "$(whoami)"

exit 0

# vim: set ft=sh:
