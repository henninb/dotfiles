#!/bin/sh

cp $HOME/.ssh/id_rsa .
cp $HOME/.ssh/known_hosts .
sudo -S -u root docker build -t clearbox .
if [ $? -ne 0 ]; then
  echo  failed docker build.
  #sudo docker build -t clearbox -f Dockerfile.debug .
fi
rm -rf id_rsa
docker rm -f clearbox
#sudo sudo docker images
#sudo docker run -dit --name clearbox -h clearbox void/stage3-amd64
#sudo docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -dit --name clearbox -h clearbox clearbox
sudo docker run -dit --name clearbox -h clearbox clearbox
sudo docker exec -it --user henninb clearbox /bin/bash

exit 0
