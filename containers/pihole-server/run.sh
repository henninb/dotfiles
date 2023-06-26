#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <platform>"
  echo "docker or podman"
  exit 1
fi

platform=$1

if [ "$platform" = "podman" ]; then
  podman stop pihole-server
  podman rm -f pihole-server
  echo "running server on port 443"

  echo 0 | sudo tee /proc/sys/net/ipv4/ip_unprivileged_port_start
  podman-compose build
  podman-compose up
elif [ "$platform" = "docker" ]; then
  docker stop pihole-server
  echo docker rm -f pihole-server
  docker rm -f pihole-server
  # echo "running server on port 443"

  blocking=$(docker ps -a --filter "expose=443"  --format '{{.ID}}')
  if [ -n "${blocking}" ]; then
    echo stop
    docker stop "${blocking}"
    docker rm -f "${blocking}"
  fi

  echo docker exec -it --user root pihole-server /bin/bash
  echo docker exec -it --user root pihole-server ss --listen
  echo docker logs pihole-server

  if command -v docker-compose; then
    # docker network create --driver=bridge mynetwork
    # docker run -d --name web1 --net mynetwork jmalloc/echo-server:latest
    # docker run -d --name web2 --net mynetwork jmalloc/echo-server:latest
    # docker run -d --name web3 --net mynetwork jmalloc/echo-server:latest
    docker compose build
    docker compose up -d
  else
    docker build -t pihole-server .
    docker run --name=pihole-server -h pihole-server -h pihole-server --restart unless-stopped -p 443:443 -d pihole-server
  fi
fi

exit 0

# https://github.com/pi-hole/docker-pi-hole/blob/master/README.md

# docker run -d \
#     --name pihole \
#     -p 53:53/tcp -p 53:53/udp \
#     -p 80:80 \
#     -p 443:443 \
#     -p 8080:8080 \
#     -e TZ="America/Chicago" \
#     -v "$(pwd)/etc-pihole/:/etc/pihole/" \
#     -v "$(pwd)/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
#     --dns=127.0.0.1 --dns=1.1.1.1 \
#     --restart=unless-stopped \
#     thenetworkchuck/networkchuck_pihole
#
# printf 'Starting up pihole container '
# for i in $(seq 1 20); do
#     if [ "$(docker inspect -f "{{.State.Health.Status}}" pihole)" == "healthy" ] ; then
#         printf ' OK'
#         echo -e "\n$(docker logs pihole 2> /dev/null | grep 'password:') for your pi-hole: https://${IP}/admin/"
#         exit 0
#     else
#         sleep 3
#         printf '.'
#     fi
#
#     if [ $i -eq 20 ] ; then
#         echo -e "\nTimed out waiting for Pi-hole start, consult check your container logs for more info (\`docker logs pihole\`)"
#         exit 1
#     fi
# done;
