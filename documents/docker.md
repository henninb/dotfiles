# docker commands

## push to docker from shell

```shell
$ docker build -t "docker.server.com/app/transfer/transfer:1.1.1" -f Dockerfile .
$ docker login docker.server.com
$ docker push docker.server.com/app/transfer/transfer:1.1.1
```

## list containers by name
```
docker inspect --format='{{.Name}}' $(sudo docker ps -aq --no-trunc)
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
