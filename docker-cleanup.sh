#!/bin/sh

docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")
docker container prune
docker image prune

# Command to run all prunes:
echo docker system prune

exit 0
