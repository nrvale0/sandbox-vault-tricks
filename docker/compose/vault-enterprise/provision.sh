#!/bin/bash

set -u

function onerr {
    echo "Executing cleanup on failure..."
    popd > /dev/null 2>&1 || true
    exit -1
}
trap onerr ERR

pushd `pwd` > /dev/null 2>&1
cd /vagrant > /dev/null 2>&1 || cd "$(dirname $0)"
    
echo "Provisioning Vault Enterprise via Docker Compose..."
(set -x ; cd docker/compose/vault-enterprise && docker-compose up --build -d)

popd > /dev/null 2>&1
