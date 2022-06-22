#!/bin/sh

docker rmi -f "$(docker images | grep "<none>" | awk "{print \$3}")"
docker container prune
docker image prune

docker container prune --force --filter "until=5m"
# Command to run all prunes:
echo docker system prune

exit 0

# vim: set ft=sh:

