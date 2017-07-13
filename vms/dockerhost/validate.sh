#!/bin/bash

set -eu

echo "Validating the Docker host..."
(set -x; cd /vagrant/vms/dockerhost && inspec exec validate.d/inspec/)
