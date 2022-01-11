#!/bin/sh

ansible-playbook -i 192.168.10.25, -u pi  -e "shell=pwd" run-shell.yml
ansible-playbook -i 192.168.10.25, -u henninb git-pull-main.yml
#ansible-playbook -i 192.168.10.25, -u pi  -e "shell=git pull origin master" run_shell.yml
ansible-playbook -u henninb -K ubuntu_install.yml

exit 0
