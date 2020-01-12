#!/bin/sh

cp ~/.ssh/id_rsa .
sudo docker build -t gentoobox .
if [ $? -ne 0 ]; then
  echo debugging
  sudo docker build -t gentoobox -f Dockerfile.debug .
fi
rm -rf id_rsa
sudo docker stop gentoobox
sudo docker rm gentoobox -f
#sudo sudo docker images
#sudo docker run -dit --name gentoobox -h gentoobox gentoo/stage3-amd64
#sudo docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -dit --name gentoobox -h gentoobox gentoobox
sudo docker run -dit --name gentoobox -h gentoobox gentoobox
sudo docker exec -it --user henninb gentoobox /bin/bash

exit 0
