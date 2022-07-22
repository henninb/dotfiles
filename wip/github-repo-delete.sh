#!/bin/sh

echo personal oath token
# curl -u BitExplorer -X "DELETE" https://api.github.com/repos/BitExplorer/somerepo
curl -u henninb -X DELETE 'https://api.github.com/repos/henninb/mooncake'

# curl --request DELETE \
#   --url https://api.github.com/authorizations \
#   --header 'authorization: Basic PASSWORD' \
#   --header 'content-type: application/json' \
#   --header 'x-github-otp: OTP' \
#   --data '{"scopes": ["public_repo"], "note": "test"}'

exit 0

# vim: set ft=sh:
