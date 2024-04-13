# docker commands

## run docker over tcp
/lib/systemd/system/docker.service
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H fd:// --containerd=/run/containerd/containerd.sock

## push to docker from shell

```shell
$ docker build -t "docker.server.com/app/transfer/transfer:1.1.1" -f Dockerfile .
$ docker login docker.server.com
$ docker push docker.server.com/app/transfer/transfer:1.1.1
```

## list containers by name
```
docker inspect --format='{{.Name}}' $(docker ps -aq --no-trunc)
```

## list docker logs
```
docker logs <container>
```

## prune system
```
docker system prune
```

## remove image
```
docker rmi -f "$(docker images | grep "<none>" | awk "{print \$3}")"
```

## pruning individual
```
docker container prune
docker image prune
```

## filter
```
docker container prune --force --filter "until=5m"
```

## macvlan
```
docker network create -d macvlan --subnet=192.168.10.0/24 --gateway=192.168.10.1  -o parent=enp3s0 macvlan-net
docker network ls
docker network rm macvlan-net
```

## json formatted
```
docker inspect --format '{{json .Config}}' raspi-finance-endpoint | jq
docker inspect --format '{{json .Config}}' raspi-finance-endpoint | jq '.ExposedPorts'
docker inspect --format '{{.Config.ExposedPorts}}' raspi-finance-endpoint
docker inspect --format '{{.Config.ExposedPorts}}'  $(docker ps -aq --no-trunc)
```

## find exposed port of a running container
```
docker ps --filter "expose=8443"
docker ps --filter "expose=8443"  --format '{{.ID}}'
```
