#!/usr/bin/env bash

SCRIPT_NAME=$(basename "$0")
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$SCRIPT_NAME" == "lib.sh" ]
then
    echo "Nope! you can't run $SCRIPT_NAME directly!";
fi

USER_UID=$(id -u)
USER_GID=$(id -g)
USER_GID_ALL=$(id -G)