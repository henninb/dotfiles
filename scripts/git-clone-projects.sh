#!/bin/sh

mkdir -p "$HOME/projects/github.com/henninb"
mkdir -p "$HOME/projects/gitlab.com/BitExplorer"

PROJECTS="netlify-cflare aws-lambda-authentication android-cribbage android-random-photo aws-cognito lambda-basic-auth aws-lambda-api netlify-cfront netlify-fastly pihole-server traefik-server haproxy-server react-app express-api weather-gtk logout-gtk nextjs-finance webpage example-ratpack raspi-finance-ratpack example-ktor raspi-finance-endpoint raspi-finance-database src-common example-java example-scala example-kotlin raspi-finance-react raspi-finance-endpoint-micronaut raspi-finance-ncurses raspi-finance-reports st cribbage cribbage-fsharp profile-website netlify-site2 netlify-site3 netlify-site4 netlify-site5 netlify-site6 netlify-site1 netlify-site7 netlify-site8 netlify-site9 nextjs-website nginx-reverse-proxy example-micronaut raspi-finance-endpoint-ktor user-agent-extension"
for i in $PROJECTS; do
  cd "$HOME/projects/github.com/henninb" || exit
  echo "$i"
  git clone "git@github.com:henninb/$i.git" 2> /dev/null
  if [ $? = 0 ]; then
    echo success
  fi
  # cd "$i" || exit
  # mkdir -p "$HOME/projects/github.com/henninb/$i"
  cd "$HOME/projects/github.com/henninb/$i" || exit
  # if ! git branch --set-upstream-to=origin/main main > /dev/null 2>&1; then
  #   echo need to convert to main branch
  #   continue
  # fi
  git config --local user.email henninb@msn.com
  git fetch --all
  git rebase origin/main
done

# PLUGINS="autojump zsh-autosuggestions zsh-syntax-highlighting"
# for i in $PLUGINS; do
#   cd "$HOME/plugins/$i" || exit
#   git fetch
# done

echo distrotube
echo git clone git@gitlab.com:dwt1/wallpapers.git

cd "$HOME/projects/gitlab.com/BitExplorer" || exit
git clone git@gitlab.com:BitExplorer/howto.git

exit 0

# vim: set ft=sh:
