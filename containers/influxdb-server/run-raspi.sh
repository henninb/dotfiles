#!/bin/sh

cat > influxdb.env <<EOF
INFLUXDB_ADMIN_USER=henninb
INFLUXDB_ADMIN_PASSWORD=monday1
INFLUXDB_DB=metrics
INFLUXDB_HTTP_ENABLED=true
INFLUXDB_HTTP_AUTH_ENABLED=true
EOF

mkdir -p "$HOME/influxdb-data"
export CURRENT_UID="$(id -u)"
export CURRENT_GID="$(id -g)"


docker run --name influxdb-server -d --restart unless-stopped --privileged -p 8086:8086 --env-file influxdb.env --user "$CURRENT_UID:$CURRENT_GID" -v "$HOME/influxdb-data:/var/lib/influxdb" influxdb:1.8.10
# docker run --name influxdb-server -d --restart unless-stopped --privileged -p 8086:8086 --env-file influxdb.env --user "$CURRENT_UID:$CURRENT_GID" -v "$HOME/influxdb-data:/var/lib/influxdb" influxdb:2.7.10

echo doas emerge --update --newuse  influx-cli

exit 0
