curl -k -u elastic:monday1 https://localhost:9200
sysctl -w vm.max_map_count=262144
curl -k http://127.0.0.1:9200/_cat/health
