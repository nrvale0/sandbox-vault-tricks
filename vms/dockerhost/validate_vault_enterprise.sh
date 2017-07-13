#!/bin/bash

set -eu

echo "Validating Vault Enterprise via InSpec..."
(set -x ; cd /vagrant/docker/compose/vault-enterprise ; inspec exec validate.d/inspec/)
