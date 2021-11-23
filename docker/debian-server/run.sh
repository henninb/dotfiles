#!/bin/sh

cp $HOME/.ssh/id_rsa .
cp $HOME/.ssh/known_hosts .

if ! sudo docker build -t debian-server .; then
  echo  failed docker build.
fi

rm -rf id_rsa
sudo docker stop debian-server
sudo docker rm debian-server -f
sudo docker run -dit --name debian-server -h debian-server debian-server
sudo docker exec -it --user henninb debian-server /bin/bash

exit 0
