FROM ubuntu:16.04
RUN apt-get update && apt-get install vim -y && apt-get install openjdk-8-jre -y

ENV kafka_version=2.11-1.1.0
ADD ./kafka_${kafka_version}.tgz ./
RUN mv kafka_${kafka_version} kafka
COPY startZookeeper.sh kafka/
