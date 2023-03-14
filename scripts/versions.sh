#!/bin/sh

date=$(date '+%Y-%m-%d')

javac --version | tee -a "$HOME/tmp/version-$date-$$.dat"
node --version | tee -a "$HOME/tmp/version-$date-$$.dat"
nvim --version | head -1 | tee -a "$HOME/tmp/version-$date-$$.dat"
xmonad --version | tee -a "$HOME/tmp/version-$date-$$.dat"
stack --version | tee -a "$HOME/tmp/version-$date-$$.dat"
alacritty --version | tee -a "$HOME/tmp/version-$date-$$.dat"
keepassxc --version | tee -a "$HOME/tmp/version-$date-$$.dat"
dzen2 -v | head -1 | tee -a "$HOME/tmp/version-$date-$$.dat"
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
brave-browser --version | tee -a "$HOME/tmp/version-$date-$$.dat"

exit 0
