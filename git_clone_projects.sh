#!/bin/sh

PROJECTS="raspi-finance-excel raspi-finance-endpoint raspi-finance-transform raspi-finance-ui raspi-finance-database raspi-finance raspi-finance-convert nfl-database src-common"
for i in $(echo $PROJECTS); do
  cd ~/projects
  git clone git@github.com:BitExplorer/$i.git
  cd $i
  git config --local user.email henninb@msn.com
  git pull
done

cd ~/projects
git clone git@gitlab.com:BitExplorer/howto.git

exit 0
