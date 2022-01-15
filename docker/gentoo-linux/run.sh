#!/bin/sh

cp ~/.ssh/id_rsa .
docker build -t gentoobox -f Dockerfile .

rm -rf id_rsa
docker stop gentoobox
docker rm gentoobox -f
#sudo sudo docker images
#sudo docker run -dit --name gentoobox -h gentoobox gentoo/stage3-amd64
#sudo docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -dit --name gentoobox -h gentoobox gentoobox
docker run -dit --name gentoobox -h gentoobox gentoobox
docker exec -it --user henninb gentoobox /bin/bash

exit 0
