#!/bin/sh

scp -r .ssh/ henninb@192.168.10.10:/home/henninb/
scp -r .zsh* henninb@192.168.10.10:/home/henninb/
scp -r zsh-install.sh henninb@192.168.10.10:/home/henninb/
scp -r postgresql-install.sh henninb@192.168.10.10:/home/henninb/
scp -r postgresql-status.sh henninb@192.168.10.10:/home/henninb/
scp -r monofur-fonts.zip henninb@192.168.10.10:/home/henninb/
scp -r java-install.sh henninb@192.168.10.10:/home/henninb/

exit 0
