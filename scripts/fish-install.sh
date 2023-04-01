#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S fish
elif [ "$OS" = "Gentoo" ]; then
  if ! command -v fish; then
    sudo emerge --update --newuse fish
  fi
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  # sudo apt install -y fish
  wget https://launchpad.net/~fish-shell/+archive/ubuntu/release-3/+files/fish_3.6.1-1~jammy_amd64.deb
  sudo dpkg -i fish_3.6.1-1_jammy_amd64.deb
  rm fish_3.6.1-1_jammy_amd64.deb
  if ! grep -Fxq "/bin/fish" /etc/shells; then
    echo "/bin/fish" | sudo tee -a /etc/shells
    echo "The string /bin/fish has been added to /etc/shells"
  fi
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y xtools
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
  sudo pkg install -y fish
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y fish
  if ! grep -Fxq "/bin/fish" /etc/shells; then
    echo "/bin/fish" | sudo tee -a /etc/shells
    echo "The string /bin/fish has been added to /etc/shells"
  fi
  # echo sudo vi /etc/shells
  # echo /bin/fish
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y fish
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  brew install fish
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

[ -s "/bin/zsh" ] && sudo usermod -s /bin/fish "$(whoami)"
[ -s "/bin/zsh" ] && sudo chsh -s /bin/fish "$(whoami)"

# vim: set ft=sh:
