#!/bin/sh

# cp "$HOME/.ssh/id_rsa" .
# cp "$HOME/.ssh/known_hosts" .

docker stop kali-server
docker rm kali-server -f

if ! docker build -t kali-server .; then
  echo  "failed docker build"
fi

# if ! docker-compose up -d; then
#   echo "failed docker-compose"
# fi

# podman stop kali-server
# podman rm kali-server -f
# podman build --tag kali-server -f ./Dockerfile
# podman run -dit --name kali-server -h kali-server kali-server
# podman exec -it --user henninb kali-server /bin/bash

# rm -rf id_rsa
docker run -dit --name kali-server -h kali-server -p 61986:61986 -p 61985:61985 -p 3000:3000 kali-server
echo docker exec -it --user root kali-server /bin/bash

exit 0
