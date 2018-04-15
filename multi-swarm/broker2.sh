#!/bin/bash
sudo docker service create \
  --name kafka2 \
  --mount type=volume,source=kafka-2-logs,destination=/tmp/kafka-logs \
  --publish 9094:9094 \
  --network kafka-net \
  --mode global \
  --constraint node.labels.kafka==2 \
   kafka:latest \
 /kafka/bin/kafka-server-start.sh /kafka/config/server.properties \
    --override listeners=LISTENER1://:9092,LISTENER2://0.0.0.0:9094 \
    --override listener.security.protocol.map=LISTENER1:PLAINTEXT,LISTENER2:PLAINTEXT \
    --override inter.broker.listener.name=LISTENER1 \
    --override advertised.listeners=LISTENER1://:9092,LISTENER2://node4:9094 \
    --override zookeeper.connect=zookeeper:2181 \
    --override broker.id=2
