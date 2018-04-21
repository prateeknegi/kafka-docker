#!/bin/bash
zk_id=$1
zk_nodes_in=$2

dataDir="/tmp/zookeeper"
zkConfDir="/kafka/config"

#TODO
#dataDir="/Users/prateeknegi/kafka-docker/zoo-data"
#zkConfDir="/Users/prateeknegi/kafka-docker/zk_config"

echo "$zk_id" | tee $dataDir/myid

template_file="${zkConfDir}/zookeeper.template"
if [ ! -f "${zkConfDir}/zookeeper.template" ]
then
   mv "${zkConfDir}/zookeeper.properties" "${zkConfDir}/zookeeper.template"
fi

IFS=', ' read -r -a zk_nodes <<< "$zk_nodes_in"

for index in "${!zk_nodes[@]}"
do
  zk_node_id=$(($index+1))
  zk_node=${zk_nodes[index]}
  zk_config="$zk_config"$'\n'"server.$zk_node_id=$zk_node:2888:3888"
done

cp "${template_file}"  "${zkConfDir}/zookeeper.properties"
echo "${zk_config}" >> "${zkConfDir}/zookeeper.properties"
