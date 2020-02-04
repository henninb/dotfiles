#!/bin/sh

docker rm fibonacci -f
docker build -t fibonacci .
docker run -it --rm --name fibonacci -p 3002:3000 -d fibonacci
#docker run -it --rm --name fibonacci -d fibonacci
sudo docker ps -a  | grep fibonacci | grep -v grep
echo sudo docker ps -a
echo curl localhost:3002

exit 0

