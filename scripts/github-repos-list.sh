#!/bin/sh

curl -s 'https://api.github.com/users/henninb/repos?per_page=1000' | jq -r '.[]|.html_url' | sed "s/https:\/\/github.com\/henninb\///g" | sort

exit 0

# vim: set ft=sh:
