#!/bin/sh

echo sudo apt install -y git zsh vim
rm -rf /home/vagrant/.bash_profile
rm -rf /home/vagrant/.bashrc
rm -rf /home/vagrant/.profile
git init /home/vagrant
git remote add origin git@github.com:BitExplorer/dotfiles.git
scp pi@192.168.100.25:/home/pi/.ssh/id_rsa /home/vagrant/.ssh/id_rsa
mv /home/vagrant/.ssh/authorized_keys /home/vagrant/.ssh/authorized_keys.bak
sudo passwd vagrant
git pull origin master
git push --set-upstream origin master
cat /home/vagrant/.ssh/authorized_keys.bak >> /home/vagrant/.ssh/authorized_keys
rm /home/vagrant/.ssh/authorized_keys.bak
exec bash

exit 0

