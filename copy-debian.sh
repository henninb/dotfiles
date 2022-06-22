#!/bin/sh

ssh henninb@192.168.10.10 "mkdir -p /home/henninb/src/api/youtube"
scp -r .ssh/ henninb@192.168.10.10:/home/henninb/
scp -r .irssi/ henninb@192.168.10.10:/home/henninb/
scp -r .zsh* henninb@192.168.10.10:/home/henninb/
scp -r .alias* henninb@192.168.10.10:/home/henninb/
scp -r .profile henninb@192.168.10.10:/home/henninb/
scp -r zsh-install.sh henninb@192.168.10.10:/home/henninb/
scp -r postgresql-install.sh henninb@192.168.10.10:/home/henninb/
scp -r postgresql-status.sh henninb@192.168.10.10:/home/henninb/
scp -r monofur-fonts.zip henninb@192.168.10.10:/home/henninb/
scp -r java-install.sh henninb@192.168.10.10:/home/henninb/
scp -r javascript-install.sh henninb@192.168.10.10:/home/henninb/
scp -r cli-install.sh henninb@192.168.10.10:/home/henninb/
scp -r docker-install.sh henninb@192.168.10.10:/home/henninb/
scp -r git-clone-projects.sh henninb@192.168.10.10:/home/henninb/
scp -r .gitignore henninb@192.168.10.10:/home/henninb/
scp -r .gitconfig henninb@192.168.10.10:/home/henninb/
scp -r ssl/ henninb@192.168.10.10:/home/henninb/
scp -r python-pip-install.sh henninb@192.168.10.10:/home/henninb/
scp -r update.sh henninb@192.168.10.10:/home/henninb/
scp -r src/api/youtube/run.sh henninb@192.168.10.10:/home/henninb/src/api/youtube/
scp -r src/api/youtube/channels.txt henninb@192.168.10.10:/home/henninb/src/api/youtube/
scp -r src/api/youtube/apikey henninb@192.168.10.10:/home/henninb/src/api/youtube/
# scp -r .config/nvim/ henninb@192.168.10.10:/home/henninb/.config


exit 0
