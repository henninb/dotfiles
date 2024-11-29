#!/bin/sh

date=$(date '+%Y-%m-%d')

export GITLAB_HOME="$HOME/gitlab-data"

docker stop gitlab-server

mkdir -p "$HOME/gitlab-data"
export CURRENT_UID="$(id -u)"
export CURRENT_GID="$(id -g)"

echo docker volume rm -f gitlab-logs
echo docker volume rm -f gitlab-config
echo docker volume rm -f gitlab-data
echo docker volume list

docker run --detach \
   --hostname gitlab-server \
   --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.lan'" \
   --publish 443:443 \
   --publish 80:80 --publish 2222:22 \
   --name gitlab-server \
   --volume gitlab-config:/etc/gitlab \
   --volume gitlab-logs:/var/log/gitlab \
   --volume gitlab-data:/var/opt/gitlab \
   --restart unless-stopped \
   --shm-size 512m \
   gitlab/gitlab-ce:latest

echo docker exec gitlab-server update-permissions
echo docker exec gitlab-server grep 'Password:' /etc/gitlab/initial_root_password
docker exec gitlab-server grep 'Password:' /etc/gitlab/initial_root_password

exit 0

 sudo docker run --detach \
   --hostname gitlab-server \
   --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.lan'" \
   --publish 443:443 --publish 80:80 --publish 2222:22 \
   --name gitlab-server \
   --user "$CURRENT_UID:$CURRENT_GID" \
   --restart unless-stopped \
   --volume $GITLAB_HOME/config:/etc/gitlab \
   --volume $GITLAB_HOME/logs:/var/log/gitlab \
   --volume $GITLAB_HOME/data:/var/opt/gitlab \
   --shm-size 256m \
   gitlab/gitlab-ce:latest
