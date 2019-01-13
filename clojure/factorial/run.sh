#!/bin/sh

docker rm factorial -f
docker build -t factorial .
docker run -it --rm --name factorial -p 3001:3000 -d factorial
#docker run -it --rm --name factorial -d factorial
sudo docker ps -a  | grep factorial | grep -v grep
echo sudo docker ps -a
echo curl localhost:3001

exit 0

