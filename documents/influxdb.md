curl -G http://192.168.10.25:8086/query -u "henninb:password" --data-urlencode "q=SHOW DATABASES"

curl -i -XPOST http://localhost:8086/query -u "henninb:${INFLUXDB_PASSWORD}" --data-urlencode "q=CREATE DATABASE metrics"
