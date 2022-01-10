#!/bin/sh

ansible-playbook -i 192.168.10.25, -u pi  -e "shell=ls" run_shell.yml
ansible-playbook -i 192.168.10.218, -u henninb git_pull_master.yml
#ansible-playbook -i 192.168.100.25, -u pi  -e "shell=git pull origin master" run_shell.yml
ansible-playbook -u henninb -K ubuntu_install.yml

exit 0
