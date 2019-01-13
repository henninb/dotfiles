#!/bin/sh

echo personal oath token
curl -u BitExplorer -X "DELETE" https://api.github.com/repos/BitExplorer/somerepo

exit 0
