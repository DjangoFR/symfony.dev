#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
USER_UID=$(id -u)

## root check
[ $USER_UID -eq 0 ] && { echo -e "\n\nRun this script as NON ROOT USER, please.\n\n"; exit 1; }

$SCRIPTDIR/stop.sh

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
rm -rf $SCRIPTDIR/../symfony/app/cache/*
rm -rf $SCRIPTDIR/../storage/mysql/*
chown $USER.$USER "$SCRIPTDIR/../symfony/" -R
chown $USER.$USER "$SCRIPTDIR/../storage/" -R
chown $USER.$USER "$SCRIPTDIR/../logs/" -R
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker
sudo service docker restart
