#!/bin/bash

kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic $1_topic --from-beginning --timeout-ms 2000 > aliens1.csv
sudo docker cp /home/msgerasymenko/$1.csv cdc4f75e959b:/var/lib/mysql/big_data
sudo mysql -u root -h 127.0.0.1 -P 3366 -p -e "use big_data; 
LOAD DATA INFILE '$1.csv' INTO TABLE $1 FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;"
