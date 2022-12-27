sysctl -w vm.max_map_count=262144
/usr/share/kibana/config


remove the volume on each upgrade or change.


docker volume rm -f elastic-server_elasticsearch-volume


curl -X GET "http://localhost:9200/_cluster/health"

docker-compose exec elasticsearch bin/elasticsearch-reset-password --batch --user elastic


flood stage disk watermark [95%] exceeded on [cts5jJd7Qc6tB_LaELeEog][3a6b31d25c0a][/usr/share/elasticsearch/data

curl -XPUT -H "Content-Type: application/json" http://localhost:9200/_cluster/settings -d '{ "transient": { "cluster.routing.allocation.disk.threshold_enabled": false } }'
curl -XPUT -H "Content-Type: application/json" http://localhost:9200/_all/_settings -d '{"index.blocks.read_only_allow_delete": null}'
