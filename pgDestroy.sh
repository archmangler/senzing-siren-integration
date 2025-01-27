#!/bin/bash

docker ps | egrep -v CONTAINER |  awk '{print $1}' | xargs -Iname  docker stop name
docker ps -a | egrep -v CONTAINER | egrep "postgres" | awk '{print $1}' | xargs -Iname docker rm name
docker volume rm postgres_data
