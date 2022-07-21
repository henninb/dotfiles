#!/bin/sh

sudo emerge dev-vcs/git
rm -rf /home/vagrant/.bash_profile
rm -rf /home/vagrant/.bashrc
rm -rf /home/vagrant/.profile
git init /home/vagrant
git remote add origin git@github.com:henninb/dotfiles.git
mv /home/vagrant/.ssh/authorized_keys /home/vagrant/.ssh/authorized_keys.bak
sudo passwd vagrant
git fetch
git merge origin/main
cat /home/vagrant/.ssh/authorized_keys.bak >> /home/vagrant/.ssh/authorized_keys
rm /home/vagrant/.ssh/authorized_keys.bak
exec bash

exit 0

