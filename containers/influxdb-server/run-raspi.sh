#!/bin/sh

cat > influxdb.env <<EOF
INFLUXDB_ADMIN_USER=henninb
INFLUXDB_ADMIN_PASSWORD=monday1
INFLUXDB_DB=metrics
INFLUXDB_HTTP_ENABLED=true
INFLUXDB_HTTP_AUTH_ENABLED=true
EOF

cat > influxdb2.env <<EOF
DOCKER_INFLUXDB_INIT_MODE=setup
DOCKER_INFLUXDB_INIT_USERNAME=henninb
DOCKER_INFLUXDB_INIT_PASSWORD=monday11
DOCKER_INFLUXDB_INIT_ORG=hornsup
DOCKER_INFLUXDB_INIT_BUCKET=metrics
DOCKER_INFLUXDB_INIT_RETENTION=1w
DOCKER_INFLUXDB_INIT_ADMIN_TOKEN=my-super-secret-auth-token
EOF

mkdir -p "$HOME/influxdb-data"
mkdir -p "$HOME/influxdb2-data"
mkdir -p "$HOME/influxdb2-config"
export CURRENT_UID="$(id -u)"
export CURRENT_GID="$(id -g)"


# docker run --name influxdb-server -d --restart unless-stopped --privileged -p 8086:8086 --env-file influxdb.env --user "$CURRENT_UID:$CURRENT_GID" -v "$HOME/influxdb-data:/var/lib/influxdb" influxdb:1.11.7
echo influxdb 1.x login process
echo docker exec -it influxdb-server influx -username henninb -password monday1

docker run --name influxdb2-server -d --restart unless-stopped --privileged -p 8086:8086 --env-file influxdb2.env --user "$CURRENT_UID:$CURRENT_GID" -v "$HOME/influxdb2-data:/var/lib/influxdb2" -v "$HOME/influxdb2-config:/etc/influxdb2" influxdb:2.7.10

echo doas emerge --update --newuse  influx-cli
echo reset password
echo influx user password -n henninb -t my-super-secret-auth-token

echo open a browser and go to http://localhost:8086/

exit 0
