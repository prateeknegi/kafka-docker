docker network create --driver overlay kafka-net

docker service create \
   --name zookeeper \
   --mount type=volume,source=zoo-swarm-data,destination=/tmp/zookeeper \
   --publish 2181:2181 \
   --network kafka-net \
   --constraint node.labels.zoo==1 \
   --mode global \
   kafka:latest \
   /kafka/bin/zookeeper-server-start.sh /kafka/config/zookeeper.properties

docker service create \
  --name kafka1 \
  --mount type=volume,source=kafka-swarm-logs,destination=/tmp/kafka-logs \
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
    --override broker.id=1

docker service create \
  --name kafka1 \
  --mount type=volume,source=kafka-swarm-logs,destination=/tmp/kafka-logs \
  --publish 9094:9094 \
  --network kafka-net \
  --mode global \
  --constraint node.labels.kafka==1 \
   kafka:latest \
 /kafka/bin/kafka-server-start.sh /kafka/config/server.properties \
    --override listeners=LISTENER1://:9092,LISTENER2://0.0.0.0:9094 \
    --override listener.security.protocol.map=LISTENER1:PLAINTEXT,LISTENER2:PLAINTEXT \
   --override inter.broker.listener.name=LISTENER1 \
    --override advertised.listeners=LISTENER1://:9092,LISTENER2://node4:9094 \
    --override broker.id=1

  docker service create \
    --name kafka1 \
    --mount type=volume,source=kafka-swarm-logs,destination=/tmp/kafka-logs \
    --publish 9095:9095 \
    --network kafka-net \
    --mode global \
    --constraint node.labels.kafka==1 \
     kafka:latest \
   /kafka/bin/kafka-server-start.sh /kafka/config/server.properties \
      --override listeners=LISTENER1://:9092,LISTENER2://0.0.0.0:9095 \
      --override listener.security.protocol.map=LISTENER1:PLAINTEXT,LISTENER2:PLAINTEXT \
     --override inter.broker.listener.name=LISTENER1 \
      --override advertised.listeners=LISTENER1://:9092,LISTENER2://node5:9095 \
      --override broker.id=1
