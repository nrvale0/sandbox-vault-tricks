#!/bin/bash

set -u

function onerr {
    echo "Executing cleanup on failure..."
    popd > /dev/null 2>&1 || true
    exit -1
}
trap onerr ERR

pushd `pwd` > /dev/null 2>&1
cd /vagrant > /dev/null 2>&1 || cd "$(dirname $0)/../../"

ls


echo "Validating the Docker host..."
(set -x; \
    inspec exec vms/dockerhost/validate.d/inspec)

popd -n > /dev/null 2>&1
