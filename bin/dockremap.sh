#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/lib.sh

## root check
[ $USER_UID -eq 0 ] && { echo -e "\n\nRun this script as NON ROOT USER, please.\n\n"; exit 1; }

$SCRIPT_DIR/stop.sh

sudo id -u dockremap &>/dev/null || sudo useradd dockremap

REMAPCNT="dockremap:$USER_UID:65536"
sudo bash <<EOF
sed -i.bak '/^dockremap/ d' /etc/subuid
echo $REMAPCNT >> /etc/subuid
sed -i.bak '/^dockremap/ d' /etc/subgid
echo $REMAPCNT >> /etc/subgid
echo '{"userns-remap": "dockremap"}' > /etc/docker/daemon.json
EOF

sudo bash <<EOF
rm -rf $SCRIPT_DIR/../symfony/app/cache/*
rm -rf $SCRIPT_DIR/../storage/mysql/*
chown $USER.$USER "$SCRIPT_DIR/../symfony/" -R
chown $USER.$USER "$SCRIPT_DIR/../storage/" -R
chown $USER.$USER "$SCRIPT_DIR/../logs/" -R
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker
sudo service docker restart
