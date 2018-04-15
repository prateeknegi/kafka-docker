#!/bin/bash
sudo docker service create \
   --name zookeeper \
   --mount type=volume,source=zoo-data,destination=/tmp/zookeeper \
   --publish 2181:2181 \
   --network kafka-net \
   --constraint node.labels.zoo==1 \
   --mode global \
   kafka:latest \
   /kafka/bin/zookeeper-server-start.sh /kafka/config/zookeeper.properties
