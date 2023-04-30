#!/bin/sh

doas systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

exit 0

# vim: set ft=sh:
