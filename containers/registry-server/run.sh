#!/bin/sh

docker run -d -p 5000:5000 --name registry registry:2
#docker tag nextjs-website 192.168.10.40:5000/nextjs-website:latest

kubectl create secret docker-registry my-registry-secret \
  --docker-server=192.168.10.40:5000 \
  --docker-username=henninb \
  --docker-password=monday1 \
  --docker-email=henninb@gmail.com

echo push image to registry
docker push 192.168.10.40:5000/nextjs-website:latest

curl -k http://localhost:5000/v2/_catalog

exit 0
