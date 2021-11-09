#!/bin/bash

sudo docker cp 54bc2cadc131:/var/lib/postgresql/$1.csv /home/msgerasymenko

kafka-console-producer.sh --bootstrap-server localhost:9092 --topic $1_topic  < $1.csv 
