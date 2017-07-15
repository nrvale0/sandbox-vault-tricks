#!/bin/bash

set -eu

function onexit {
    echo "Executing cleanup on failure..."
    popd > /dev/null 2>&1
    exit -1
}
trap onexit EXIT

pushd "$(dirname $0)" > /dev/null 2>&1

echo "Provisioning Vault Enterprise via Docker Compose..."
(set -x ; docker-compose up --build -d)

popd > /dev/null 2>&1
