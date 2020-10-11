#!/bin/sh

PROJECTS="raspi-finance-endpoint raspi-finance-database raspi-finance-convert nfl-database src-common example-java example-scala example-kotlin raspi-finance-react raspi-finance-endpoint-micronaut raspi-finance-ncurses raspi-finance-reports st cribbage cribbage-fsharp"
for i in $PROJECTS; do
  cd "$HOME/projects" || exit
  git clone "git@github.com:BitExplorer/$i.git"
  cd "$i" || exit
  git branch --set-upstream-to=origin/master master
  git config --local user.email henninb@msn.com
  git pull
done

cd "$HOME/projects" || exit
git clone git@gitlab.com:BitExplorer/howto.git

PLUGINS="autojump zsh-autosuggestions zsh-syntax-highlighting"
for i in $PLUGINS; do
  cd "$HOME/plugins/$i" || exit
  git pull
done

THEME="agnoster-zsh-theme alien dracula-zsh-theme spaceship-prompt"
for i in $THEME; do
  cd "$HOME/themes/$i" || exit
  git pull
done

echo distrotube
echo git clone git@gitlab.com:dwt1/wallpapers.git

exit 0
