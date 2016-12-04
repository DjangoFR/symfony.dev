#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/lib.sh

if timeout 1 bash -c "</dev/tcp/127.0.0.1/80" 2> /dev/null ; then
    lsof -i:80
    echo -e "\nPort 80 is already used.\nCan't start!"
    exit 1
fi
if timeout 1 bash -c "</dev/tcp/127.0.0.1/3306" 2> /dev/null ; then
    lsof -i:3306
    echo -e "\nPort 3306 is already used.\nCan't start!"
    exit 1
fi

exit 0
