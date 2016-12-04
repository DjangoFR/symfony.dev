#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/lib.sh

if [ $# -eq 0 ] 
then
    echo -e "\n\tusage: $SCRIPT_NAME <CONTAINER ID>\n"
    docker ps
    echo -e "\n\n"
    exit 4
fi

CONTAINER=$1
RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)

if [ $? -eq 1 ]; then
  echo "UNKNOWN - $CONTAINER does not exist."
  exit 3
fi

if [ "$RUNNING" == "false" ]; then
  echo "CRITICAL - $CONTAINER is not running."
  exit 2
fi

GHOST=$(docker inspect --format="{{ .State.Ghost }}" $CONTAINER 2> /dev/null)

if [ "$GHOST" == "true" ]; then
  echo "WARNING - $CONTAINER has been ghosted."
  exit 1
fi

STARTED=$(docker inspect --format="{{ .State.StartedAt }}" $CONTAINER 2> /dev/null)
NETWORK=$(docker inspect --format="{{ .NetworkSettings.IPAddress }}" $CONTAINER 2> /dev/null)

echo "OK - $CONTAINER is running. IP: $NETWORK, StartedAt: $STARTED"
