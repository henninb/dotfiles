#!/bin/sh

cp ~/.ssh/id_rsa .
sudo docker build -t voidbox .
if [ $? -ne 0 ]; then
  echo debugging
  sudo docker build -t voidbox -f Dockerfile.debug .
fi
rm -rf id_rsa
sudo docker stop voidbox
sudo docker rm voidbox -f
#sudo sudo docker images
#sudo docker run -dit --name voidbox -h voidbox void/stage3-amd64
#sudo docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -dit --name voidbox -h voidbox voidbox
sudo docker run -dit --name voidbox -h voidbox voidbox
sudo docker exec -it --user henninb voidbox /bin/bash

exit 0
