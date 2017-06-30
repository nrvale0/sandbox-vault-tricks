#!/bin/bash

: ${PROVISION_VAULT_ENTERPRISE:="false"}

set -eu

echo "Provision the Docker host..."

echo "Installing packages..."
(set -x ; apt-get update && apt-get install -y git)

echo "Installing Docker Compose..."
(set -x ; 
 wget -q -O /usr/local/bin/docker-compose -c https://github.com/docker/compose/releases/download/1.14.0/docker-compose-Linux-x86_64 ;
 chmod +x /usr/local/bin/docker-compose)

echo "Launching Services via Docker Compose..."
(set -x ;
 cd /vagrant ;
 docker-compose up -d)

if [ "false" != "${PROVISION_VAULT_ENTERPRISE}" ]; then
  echo "Also launching Vault Enterprise via Docker Compose..."
  (set -x ;
   cd /vagrant ;
   docker-compose -f docker-compose.yml -f docker-compose-vault-enterprise.yml build ;
   docker-compose -f docker-compose.yml -f docker-compose-vault-enterprise.yml up -d)
fi

echo "Installing BASH Automated Test System..."
(set -x ;
 rm -rf /tmp/bats ;
 git clone https://github.com/sstephenson/bats /tmp/bats ;
 cd /tmp/bats ;
 ./install.sh /usr/local ;
 rm -rf /tmp/bats)
