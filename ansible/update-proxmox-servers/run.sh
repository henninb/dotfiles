#!/bin/sh

ansible-playbook -i 192.168.10.4, -u root -e "shell='sudo apt update && sudo apt upgrade -y'" run-shell.yml
ansible-playbook -i hornsup, -u henninb -e "shell='sudo apt update && sudo apt upgrade -y'" run-shell.yml

exit 0
