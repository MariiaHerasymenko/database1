#!/bin/bash

sudo mysql -u root -h 127.0.0.1 -P 3366 -p -e "use big_data; 

select accident_id, alien_id, witness_id, location_id, time_of_day  into outfile '/var/lib/mysql/accidents.csv' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' from accidents;

select witness_id, witness_name, witness_last_name, witness_address, witness_age  into outfile '/var/lib/mysql/witnesses.csv' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' from witnesses;

select location_id, lat, lon, place, country, region  into outfile '/var/lib/mysql/locations.csv' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' from locations;

select alien_id, alien_name, alien_type, alien_color  into outfile '/var/lib/mysql/aliens.csv' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' from aliens; \q"

sudo docker cp cdc4f75e959b:/var/lib/mysql/accidents.csv /home/msgerasymenko
sudo docker cp cdc4f75e959b:/var/lib/mysql/witnesses.csv /home/msgerasymenko
sudo docker cp cdc4f75e959b:/var/lib/mysql/locations.csv /home/msgerasymenko
sudo docker cp cdc4f75e959b:/var/lib/mysql/aliens.csv /home/msgerasymenko

sudo docker cp /home/msgerasymenko/accidents.csv 54bc2cadc131:/var/lib/postgresql
sudo docker cp /home/msgerasymenko/witnesses.csv 54bc2cadc131:/var/lib/postgresql
sudo docker cp /home/msgerasymenko/locations.csv 54bc2cadc131:/var/lib/postgresql
sudo docker cp /home/msgerasymenko/aliens.csv 54bc2cadc131:/var/lib/postgresql

sudo psql -h 127.0.0.1 -p 5533 -U postgres -d big_data -c "copy aliens (alien_id, alien_name, alien_type, alien_color) from '/var/lib/postgresql/aliens.csv' delimiter ',' csv header;

copy witnesses (witness_id, witness_name, witness_last_name, witness_address, witness_age) from '/var/lib/postgresql/witnesses.csv' delimiter ',' csv header;

copy locations (location_id, lat, lon, country, place, region) from '/var/lib/postgresql/locations.csv' delimiter ',' csv header;

copy accidents (alien_id, witness_id, location_id, time_of_day) from '/var/lib/postgresql/accidents.csv' delimiter ',' csv header;"
