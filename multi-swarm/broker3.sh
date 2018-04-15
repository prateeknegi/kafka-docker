#!/bin/bash
sudo docker service create \
    --name kafka3 \
    --mount type=volume,source=kafka-3-logs,destination=/tmp/kafka-logs \
    --publish 9095:9095 \
    --network kafka-net \
    --mode global \
    --constraint node.labels.kafka==3 \
     kafka:latest \
   /kafka/bin/kafka-server-start.sh /kafka/config/server.properties \
      --override listeners=LISTENER1://:9092,LISTENER2://0.0.0.0:9095 \
      --override listener.security.protocol.map=LISTENER1:PLAINTEXT,LISTENER2:PLAINTEXT \
      --override inter.broker.listener.name=LISTENER1 \
      --override advertised.listeners=LISTENER1://:9092,LISTENER2://node5:9095 \
      --override zookeeper.connect=zookeeper:2181 \
      --override broker.id=3
