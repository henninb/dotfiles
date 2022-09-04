#!/bin/sh

ansible hornsup -m ping
ansible-playbook -i hornsup, -u henninb docker-container-restart.yml
exit 0
