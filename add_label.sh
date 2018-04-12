#!/bin/bash
sudo docker node update --label-add kafka=3 node5
sudo docker node update --label-add kafka=1 node3
sudo docker node update --label-add kafka=2 node4
sudo docker node update --label-add zoo=1 node3
