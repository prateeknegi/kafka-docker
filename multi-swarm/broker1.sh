#!/bin/bash
sudo docker service create \
  --name kafka1 \
  --mount type=volume,source=kafka-1-logs,destination=/tmp/kafka-logs \
  --publish 9093:9093 \
  --network kafka-net \
  --mode global \
  --constraint node.labels.kafka==1 \
   kafka:latest \
 /kafka/bin/kafka-server-start.sh /kafka/config/server.properties \
    --override listeners=LISTENER1://:9092,LISTENER2://0.0.0.0:9093 \
    --override listener.security.protocol.map=LISTENER1:PLAINTEXT,LISTENER2:PLAINTEXT \
    --override inter.broker.listener.name=LISTENER1 \
    --override advertised.listeners=LISTENER1://:9092,LISTENER2://node3:9093 \
    --override zookeeper.connect=zookeeper:2181 \
    --override broker.id=1

