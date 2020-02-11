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
  sudo emerge --update --newuse zsh
  sudo emerge --update --newuse media-fonts/urw-fonts
elif [ "$OS" = "void" ]; then
  sudo xbps-install -y zsh
  sudo xbps-install -y curl
elif [ "$OS" = "Darwin" ]; then
  brew install zsh
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

# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# git checkout .zshrc
# echo cp ~/.zshrc.pre-oh-my-zsh  ~/.zshrc

# echo "Workaround for the dark blue color issue with agnoster theme"
# TODO: no longer required, lightend the blue on the zsh shell
#sed -i '0,/blue/{s/blue/39d/}' ~/.oh-my-zsh/themes/agnoster.zsh-theme

# sed -i 's/blue $CURRENT_FG/39d $CURRENT_FG/' ~/.oh-my-zsh/themes/agnoster.zsh-theme

## download plugins and themes
echo curl -fsSL https://starship.rs/install.sh | bash

git clone git://github.com/zsh-users/zsh-autosuggestions.git ${HOME}/plugins/zsh-autosuggestions

git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/plugins/zsh-syntax-highlighting

git clone git://github.com/wting/autojump.git $HOME/plugins/autojump

git clone --recursive git://github.com/eendroroy/zed-zsh $HOME/plugins/zed-zsh

git clone git://github.com/zsh-users/zsh-history-substring-search.git $HOME/plugins/zsh-history-substring-search

git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install

git clone git://github.com/denysdovhan/spaceship-prompt.git ${HOME}/themes/spaceship-prompt

git clone git://github.com/eendroroy/alien.git $HOME/themes/alien
cd $HOME/themes/alien
git submodule update --init --recursive
cd -

git clone git@github.com:agnoster/agnoster-zsh-theme.git $HOME/themes/agnoster-zsh-theme
git clone git@github.com:dracula/zsh.git $HOME/themes/dracula-zsh-theme


## download plugins and themes

# git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt

# ln -sfn "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship.zsh-theme"

# git clone git://github.com/wting/autojump.git
# cd autojump
# ./install.py
# cd -

# echo add to .zshrc
# echo source ~/alien/alien.zsh

[ -s "/usr/bin/zsh" ] && sudo usermod -s /usr/bin/zsh $(whoami)
[ -s "/usr/bin/zsh" ] && sudo chsh -s /usr/bin/zsh $(whoami)

[ -s "/bin/zsh" ] && sudo usermod -s /bin/zsh $(whoami)
[ -s "/bin/zsh" ] && sudo chsh -s /bin/zsh $(whoami)

[ -s "/usr/local/bin/zsh" ] && sudo usermod -s /usr/local/bin/zsh $(whoami)
[ -s "/usr/local/bin/zsh" ] && sudo chsh -s /usr/local/bin/zsh $(whoami)

echo sudo vipw #fixes passwd file for freebsd

#for i in $fpath; do echo $i; ls -l $i | egrep -i "(async|pure)"; done

exit 0
