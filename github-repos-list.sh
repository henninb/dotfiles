#!/bin/sh

#curl https://api.github.com/users/BitExplorer/repos
curl -s https://api.github.com/users/BitExplorer/repos?per_page=100 | jq -r '.[]|.html_url'
# Link: <https://api.github.com/user/repos?page=3&per_page=100>; rel="next",
#   <https://api.github.com/user/repos?page=50&per_page=100>; rel="last"

exit 0
