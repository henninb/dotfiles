#!/bin/sh

echo 'export EDITOR=vim' | sudo tee -a /etc/bash.bashrc

sudo ln -sfn /usr/bin/vim /bin/vim
sudo ln -sfn /usr/bin/nvim /bin/nvim
sudo sed -i "s/nano/vim/g" /etc/profile

# echo archlinux add a file to /etc/profile.d/
# echo archlinux add /etc/bash.bashrc

exit 0
# vim: set ft=sh:
