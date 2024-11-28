export INFLUX_URL=http://finance-db.lan:8086
export INFLUX_USERNAME=henninb
export INFLUX_PASSWORD=monday1

export ORG_NAME="my_org"
export ORG_ID="your_org_id"

# export INFLUX_TOKEN="your_influxdb_token"
# influx v1 shell
# influx auth create
influx auth create --org $ORG_NAME --read-buckets --write-buckets


docker exec -it influxdb-server influx setup \
  --username henninb \
  --password monday11 \
  --org hornsup \
  --bucket bucket \
  --force
