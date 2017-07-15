#!/bin/bash

set -eu

function onexit {
    echo "Executing cleanup on failure..."
    popd > /dev/null 2>&1
    exit -1
}
trap onexit EXIT

pushd "$(dirname $0)" > /dev/null 2>&1

echo "Validating Vault Enterprise via InSpec..."
(set -x ; inspec exec validate.d/inspec/)

popd > /dev/null 2>&1
