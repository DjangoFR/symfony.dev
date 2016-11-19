#!/bin/bash

docker-compose down
#docker-compose --verbose build
docker-compose build --no-cache
docker images
