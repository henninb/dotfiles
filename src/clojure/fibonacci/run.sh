#!/bin/sh

docker rm fibonacci -f
docker build -t fibonacci .
docker run -it --rm --name fibonacci -p 3002:3000 -d fibonacci
#docker run -it --rm --name fibonacci -d fibonacci
docker ps -a  | grep fibonacci | grep -v grep
echo "curl -s localhost:3002 | jq"
curl -s localhost:3002 | jq

exit 0

