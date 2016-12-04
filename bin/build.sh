#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/lib.sh

$SCRIPT_DIR/stop.sh

#docker-compose --verbose build
docker-compose build --no-cache
docker images
