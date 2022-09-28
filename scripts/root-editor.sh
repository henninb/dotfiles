#!/bin/sh

echo 'export EDITOR=vim' | sudo tee -a /root/.bashrc

sudo ln -sfn /usr/bin/vim /bin/vim
sudo ln -sfn /usr/bin/nvim /bin/nvim
sudo sed -i "s/nano/vim/g" /etc/profile

exit 0
