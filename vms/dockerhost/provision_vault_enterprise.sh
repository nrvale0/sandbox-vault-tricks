#!/bin/bash

set -eu

echo "Provisioning Vault Enterprise via Docker Compose..."
(set -x ; cd /vagrant/docker/compose/vault-enterprise ; docker-compose up --build -d)
