#!/bin/bash


if [ $# -eq 0 ] 
then
    SCRIPT=`basename "$0"`
    echo -e "\n\tusage: $SCRIPT <CONTAINER ID>\n"
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

GHOST=$(docker inspect --format="{{ .State.Ghost }}" $CONTAINER)

if [ "$GHOST" == "true" ]; then
  echo "WARNING - $CONTAINER has been ghosted."
  exit 1
fi

docker exec -it $CONTAINER /bin/bash
