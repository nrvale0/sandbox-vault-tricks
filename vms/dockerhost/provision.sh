#!/bin/bash

set -eu

function onexit {
    echo "Executing cleanup on failure..."
    popd > /dev/null 2>&1
    exit -1
}
trap onexit EXIT

pushd "$(dirname $0)" > /dev/null 2>&1

echo "Provision the Docker host..."

echo "Installing packages..."
(set -x ; apt-get update && apt-get install -y git)

echo "Installing InSpec for system validation...."
(set -x ; curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec && /opt/inspec/embedded/bin/gem install rake)

echo "Make dockerd available on all tcp/2375 on all interfaces..."
(set -x ;
  mkdir -p /etc/systemd/system/docker.service.d ;
  printf "[Service]\nExecStart=\nExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375\n" > /etc/systemd/system/docker.service.d/10-listen.conf ;
  systemctl daemon-reload ;
  service docker restart)

echo "Installing Portainer Docker container emanagement interface..."
(set -x ; docker run -d --name portainer -p 9000:9000 -v "/var/run/docker.sock:/var/run/docker.sock" portainer/portainer)

echo "Installing Docker Compose..."
(set -x ; 
 wget -c -q -O /usr/local/bin/docker-compose -c https://github.com/docker/compose/releases/download/1.14.0/docker-compose-Linux-x86_64 ;
 chmod +x /usr/local/bin/docker-compose)

popd > /dev/null 2>&1
