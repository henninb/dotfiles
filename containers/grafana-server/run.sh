#!/bin/sh

cat > grafana.env <<EOF
GF_SECURITY_ADMIN_USER=henninb
GF_SECURITY_ADMIN_PASSWORD=monday1
GF_HOST=localhost
GF_USER=henninb
GF_PASS=monday1
EOF

mkdir -p "$HOME/grafana-data"
export CURRENT_UID="$(id -u)"
export CURRENT_GID="$(id -g)"

export DOCKER_HOST=ssh://henninb@192.168.10.10

docker rm -f grafana-server
# docker run --name grafana-server -d --restart unless-stopped --privileged -p 3000:3000 --env-file grafana.env --user "$CURRENT_UID:$CURRENT_GID" -v "/home/pi/grafana-data:/var/lib/grafana" grafana/grafana:10.4.2
docker run --name grafana-server -d --restart unless-stopped --privileged -p 3001:3000 --env-file grafana.env grafana/grafana:10.4.2

exit 0
