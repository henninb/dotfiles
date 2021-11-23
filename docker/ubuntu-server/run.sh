#!/bin/sh

cp $HOME/.ssh/id_rsa .
cp $HOME/.ssh/known_hosts .

if ! sudo docker build -t ubuntu-server .; then
  echo  failed docker build.
fi

rm -rf id_rsa
sudo docker stop ubuntu-server
sudo docker rm ubuntu-server -f
sudo docker run -dit --name ubuntu-server -h ubuntu-server ubuntu-server
sudo docker exec -it --user henninb ubuntu-server /bin/bash

exit 0
