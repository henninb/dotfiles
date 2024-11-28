#!/bin/sh

cat > influxdb.env <<EOF
INFLUXDB_ADMIN_USER=henninb
INFLUXDB_ADMIN_PASSWORD=monday1
INFLUXDB_DB=metrics
INFLUXDB_HTTP_ENABLED=true
INFLUXDB_HTTP_AUTH_ENABLED=true
EOF


mkdir -p "$HOME/influxdb-data"
mkdir -p "$HOME/influxdb-config"
export CURRENT_UID="$(id -u)"
export CURRENT_GID="$(id -g)"


docker run --name influxdb-server -d --restart unless-stopped --privileged -p 8086:8086 --env-file influxdb.env --user "$CURRENT_UID:$CURRENT_GID" -v "$HOME/influxdb-data:/var/lib/influxdb" influxdb:1.11.7
echo influxdb 1.x login process
echo docker exec -it influxdb-server influx -username henninb -password monday1


echo doas emerge --update --newuse  influx-cli
echo reset password

echo open a browser and go to http://localhost:8086/

exit 0
