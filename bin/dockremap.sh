#!/bin/bash

USER_UID=$(id -u)

## Check for it
[ $USER_UID -eq 0 ] && { echo -e "\n\nRun this script as NON ROOT USER, please.\n\n"; exit 1; }

sudo id -u dockremap &>/dev/null || sudo useradd dockremap

REMAPCNT="dockremap:$USER_UID:65536"
sudo bash <<EOF
echo $REMAPCNT >> /etc/subuid
echo $REMAPCNT >> /etc/subgid
echo '{"userns-remap": "dockremap"}' > /etc/docker/daemon.json
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker
sudo service docker restart
