#!/bin/sh

rm -rf gentoo
mkdir -p gentoo
cp -R ~/gentoo .
cp ~/.ssh/id_rsa .

docker build -t gentoobox -f Dockerfile .
rm -rf gentoo

rm -rf id_rsa
docker stop gentoobox
docker rm gentoobox -f
docker run -dit --name gentoobox -h gentoobox gentoobox
echo docker exec -it --user henninb gentoobox /bin/bash
docker exec -it --user henninb gentoobox /bin/bash

exit 0
