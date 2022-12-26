sysctl -w vm.max_map_count=262144
/usr/share/kibana/config


remove the volume on each upgrade or change.


docker volume rm -f elastic-server_elasticsearch-volume
