#!/bin/bash

: ${PROVISION_VAULT_ENTERPRISE:="false"}

set -eu

echo "Provision the Docker host..."

echo "Installing packages..."
(set -x ; apt-get update && apt-get install -y git)

echo "Make dockerd available on all tcp/2375 on all interfaces..."
(set -x ;
  mkdir -p /etc/systemd/system/docker.service.d ;
  printf "[Service]\nExecStart=\nExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375\n" > /etc/systemd/system/docker.service.d/10-listen.conf ;
  systemctl daemon-reload ;
  service docker restart)

echo "Installing Docker Compose..."
(set -x ; 
 wget -q -O /usr/local/bin/docker-compose -c https://github.com/docker/compose/releases/download/1.14.0/docker-compose-Linux-x86_64 ;
 chmod +x /usr/local/bin/docker-compose)

echo "Launching Services via Docker Compose..."
(set -x ;
 cd /vagrant/docker/compose/vault-enterprise ;
 docker-compose up -d --build)