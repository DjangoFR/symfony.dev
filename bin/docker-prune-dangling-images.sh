#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/lib.sh

docker rmi -f $(docker images -f "dangling=true" -q)


# docker system prune
# docker image prune
