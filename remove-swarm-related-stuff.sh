#!/bin/sh
docker service rm zookeeper
docker service rm kafka1
docker volume rm kafka-swarm-logs
docker volume rm zoo-swarm-data
docker network rm kafka-net

docker service ls
docker volume ls
docker network ls
