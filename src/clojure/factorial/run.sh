#!/bin/sh

if [ -x "$(command -v docker)" ]; then
  docker rm factorial -f
  docker build -t factorial .
  docker run -it --rm --name factorial -p 3001:3000 -d factorial
  #docker run -it --rm --name factorial -d factorial
  docker ps -a  | grep factorial | grep -v grep
echo docker ps -a
fi
echo "curl -s localhost:3001 | jq"
curl -s localhost:3001 | jq

exit 0

