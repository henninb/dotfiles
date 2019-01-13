#!/bin/sh

#curl https://api.github.com/users/BitExplorer/repos
curl https://api.github.com/users/BitExplorer/repos | jq '.[]|.html_url'

exit 0
