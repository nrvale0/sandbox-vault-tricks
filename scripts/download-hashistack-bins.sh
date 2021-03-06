#!/bin/bash

set -e
if [ "${DEBUG}" ]; then
    set -x
fi
set -u

: ${CONSUL_VERSION:="0.9.0"}
: ${VAULT_VERSION:="0.7.3"}

: ${CONSUL_REMOTE_DIR:="s3://hc-enterprise-binaries/consul-enterprise/${CONSUL_VERSION}/"}
: ${VAULT_REMOTE_DIR:="s3://hc-enterprise-binaries/vault-enterprise/${VAULT_VERSION}/"}

: ${CONSUL_REMOTE_FILE:="consul-enterprise_${CONSUL_VERSION}+ent_linux_amd64.zip"}
: ${VAULT_REMOTE_FILE:="vault-enterprise_${VAULT_VERSION}_linux_amd64.zip"}

: ${REMOTE_LS:="aws s3 ls"}
: ${REMOTE_CP:="aws s3 cp"}


echo "Available Consul versions..."
${REMOTE_LS} ${CONSUL_REMOTE_DIR}
echo "Downloading ${CONSUL_REMOTE_FILE}..."
${REMOTE_CP} "${CONSUL_REMOTE_DIR}${CONSUL_REMOTE_FILE}" /tmp/consul.zip
(cd docker/images/consul-vault-enterprise/binaries && unzip -o /tmp/consul.zip)

    
echo "Available Vault versions..."
${REMOTE_LS} ${VAULT_REMOTE_DIR}
echo "Downloading ${VAULT_REMOTE_FILE}..."
${REMOTE_CP} "${VAULT_REMOTE_DIR}${VAULT_REMOTE_FILE}" /tmp/vault.zip
(cd docker/images/consul-vault-enterprise/binaries && unzip -o /tmp/vault.zip)


