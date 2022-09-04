#!/bin/sh

ansible hornsup -m ping
ansible-playbook -i hornsup, -u henninb git-pull-main.yml

exit 0
