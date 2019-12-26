#!/bin/sh

# if [ ! -d "$HOME/.emacs.d/evil" ]; then
#   git clone git@github.com:emacs-evil/evil.git $HOME/.emacs.d/evil
# fi

if [ ! -d "$HOME/.emacs.d/color-theme-sanityinc-tomorrow" ]; then
  git clone git@github.com:purcell/color-theme-sanityinc-tomorrow.git $HOME/.emacs.d/color-theme-sanityinc-tomorrow
fi

if [ ! -d "$HOME/.emacs.d/prettier-emacs" ]; then
  git clone git@github.com:prettier/prettier-emacs.git $HOME/.emacs.d/prettier-emacs
fi

rm -rf  ~/.emacs.d
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
mv ~/.emacs ~/.emacs.bak

if [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y emacs
fi

exit 0
