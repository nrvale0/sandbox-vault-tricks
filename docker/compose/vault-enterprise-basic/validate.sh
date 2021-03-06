#!/bin/bash

set -u

function onerr {
    echo "Executing cleanup on failure..."
    popd > /dev/null 2>&1 || true
    exit -1
}
trap onerr ERR

pushd "$(dirname $0)" > /dev/null 2>&1
cd /vagrant || cd "$(dirname $0)"


function consul_enterprise0_ip() {
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
}

echo "Validating Vault Enterprise via InSpec..."
(set -x && \
     inspec exec docker/compose/vault-enterprise/validate.d/inspec/containers.rb && \
     inspec exec docker/compose/vault-enterprise/validate.d/inspec/consul.rb && \
     inspec exec docker/compose/vault-enterprise/validate.d/inspec/vault.rb)

popd > /dev/null 2>&1
