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


docker run --name grafana-server -d --restart unless-stopped --privileged -p 3000:3000 --env-file grafana.env --user "$CURRENT_UID:$CURRENT_GID" -v "$HOME/grafana-data:/var/lib/grafana" grafana/grafana:9.3.2
