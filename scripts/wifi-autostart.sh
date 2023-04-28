#!/bin/sh

# systemctl enable netctl-auto@ <interface>.service
# systemctl enable netctl-ifplugd@ <interface>.service

sudo systemctl enable netctl-auto@wlp0s20u9.service
sudo systemctl enable netctl-ifplugd@wlp0s20u9.service

exit 0

# vim: set ft=sh:
