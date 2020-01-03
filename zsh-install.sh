#!/bin/sh

if [ "$OS" = "CentOS Linux" ]; then
  if [ "$OS_VER" = "8" ]; then
    sudo dnf install -y zsh
  else
    sudo yum install -y zsh
  fi
elif [ \( "$OS" = "Arch Linux" \) -o \( "$OS" = "Manjaro Linux" \) ]; then
  sudo pacman  --noconfirm --needed -S zsh
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  sudo apt install -y zsh
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y zsh
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge zsh
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install -y util-linux-user
  sudo dnf install -y zsh
else
  echo $OS is not yet implemented.
  exit 1
fi

# if [ ! -d "$HOME/.solarized" ]; then
#   git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git ~/.solarized
# fi

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git checkout .zshrc
echo cp ~/.zshrc.pre-oh-my-zsh  ~/.zshrc

echo "Workaround for the dark blue color issue with agnoster theme"
#sed -i '0,/blue/{s/blue/39d/}' ~/.oh-my-zsh/themes/agnoster.zsh-theme

sed -i 's/blue $CURRENT_FG/39d $CURRENT_FG/' ~/.oh-my-zsh/themes/agnoster.zsh-theme

git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

[ -s "/usr/bin/zsh" ] && sudo usermod -s /usr/bin/zsh $(whoami)
[ -s "/usr/bin/zsh" ] && sudo chsh -s /usr/bin/zsh $(whoami)

[ -s "/bin/zsh" ] && sudo usermod -s /bin/zsh $(whoami)
[ -s "/bin/zsh" ] && sudo chsh -s /bin/zsh $(whoami)

[ -s "/usr/local/bin/zsh" ] && sudo usermod -s /usr/local/bin/zsh $(whoami)
[ -s "/usr/local/bin/zsh" ] && sudo chsh -s /usr/local/bin/zsh $(whoami)

echo sudo vipw #fixes passwd file for freebsd

exit 0
