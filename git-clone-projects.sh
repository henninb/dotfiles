#!/bin/sh

PROJECTS="raspi-finance-endpoint raspi-finance-ui raspi-finance-database raspi-finance raspi-finance-client raspi-finance-convert nfl-database src-common"
for i in $(echo $PROJECTS); do
  cd $HOME/projects
  git clone git@github.com:BitExplorer/$i.git
  cd $i
  git branch --set-upstream-to=origin/master master
  git config --local user.email henninb@msn.com
  git pull
done

cd $HOME/projects
git clone git@gitlab.com:BitExplorer/howto.git

PLUGINS="autojump zsh-autosuggestions zsh-syntax-highlighting"
for i in $(echo $PLUGINS); do
  cd $HOME/plugins
  echo $i
  cd $i
  git pull
done

THEME="agnoster-zsh-theme  alien  dracula-zsh-theme  spaceship-prompt"
for i in $(echo $THEME); do
  cd $HOME/themes
  echo $i
  cd $i
  git pull
done

echo distrotube
echo git clone git@gitlab.com:dwt1/wallpapers.git

exit 0
