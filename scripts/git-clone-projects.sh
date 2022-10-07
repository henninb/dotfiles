#!/bin/sh

mkdir -p "$HOME/projects/github.com/henninb"
mkdir -p "$HOME/projects/gitlab.com/BitExplorer"

PROJECTS="weather-gtk logout-gtk nextjs-website webpage example-ratpack raspi-finance-ratpack example-ktor raspi-finance-endpoint raspi-finance-database src-common example-java example-scala example-kotlin raspi-finance-react raspi-finance-endpoint-micronaut raspi-finance-ncurses raspi-finance-reports st cribbage cribbage-fsharp profile-website netlify-site2 netlify-site3 netlify-site4 netlify-site5 netlify-site6 netlify-site1 netlify-site7 netlify-site8 netlify-site9 nextjs-website nginx-reverse-proxy heroku-site1 heroku-site2 heroku-site3 heroku-site4 heroku-site5 heroku-site6 heroku-site7 heroku-site8 heroku-site9"
for i in $PROJECTS; do
  cd "$HOME/projects/github.com/henninb" || exit
  echo "$i"
  git clone "git@github.com:henninb/$i.git" 2> /dev/null
  # cd "$i" || exit
  cd "$HOME/projects/github.com/henninb/$i" || exit
  # if ! git branch --set-upstream-to=origin/main main > /dev/null 2>&1; then
  #   echo need to convert to main branch
  #   continue
  # fi
  git config --local user.email henninb@msn.com
  git fetch --all
  git rebase origin/main
done

PLUGINS="autojump zsh-autosuggestions zsh-syntax-highlighting"
for i in $PLUGINS; do
  cd "$HOME/plugins/$i" || exit
  git fetch
done

echo distrotube
echo git clone git@gitlab.com:dwt1/wallpapers.git

cd "$HOME/projects/gitlab.com/BitExplorer" || exit
git clone git@gitlab.com:BitExplorer/howto.git

exit 0

# vim: set ft=sh:
