#!/bin/sh

cp $HOME/.ssh/id_rsa .
cp $HOME/.ssh/known_hosts .
sudo docker build -t clearlinux .
if [ $? -ne 0 ]; then
  echo  failed docker build.
  #sudo docker build -t clearlinux -f Dockerfile.debug .
fi
rm -rf id_rsa
sudo docker stop clearlinux
sudo docker rm clearlinux -f
#sudo sudo docker images
#sudo docker run -dit --name clearlinux -h clearlinux void/stage3-amd64
#sudo docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -dit --name clearlinux -h clearlinux clearlinux
sudo docker run -dit --name clearlinux -h clearlinux clearlinux
sudo docker exec -it --user henninb clearlinux /bin/bash

exit 0
