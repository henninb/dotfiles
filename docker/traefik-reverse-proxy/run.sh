#!/bin/sh

docker stop traefik-reverse-proxy
docker rm traefik-reverse-proxy -f
docker rmi traefik-reverse-proxy

echo docker exec -it --user root traefik-reverse-proxy sh
echo docker exec -it --user root traefik-reverse-proxy ss --listen
echo docker logs traefik-reverse-proxy

if ! command -v docker-compose; then
  docker-compose build
  docker-compose up
else
  docker run -d -p 8080:8080 -p 80:80 -v $PWD/traefik.yml:/etc/traefik/traefik.yml -v /var/run/docker.sock:/var/run/docker.sock traefik
  # docker build -t traefik-reverse-proxy .
  # docker run --name=traefik-reverse-proxy -h traefik-reverse-proxy -h traefik-reverse-proxy --restart unless-stopped -p 8401:8401 -p 8403:8403 -p 8405:8405 -p 8406:8406 -p 8410:8410 -d traefik-reverse-proxy
fi

exit 0
