#!/bin/bash

set -u

: ${VAULT_ADDR:="http://localhost:8200"}

clear
printf "VAULT_ADDR = \'${VAULT_ADDR}\'..."

printf "\nChecking for running Vault...\n"
(set -ex ; vault status)

vault auth -methods | grep ldap 2>&1 > /dev/null 
if [ "0" == "$?" ]; then
    printf "\nLDAP backend already installed.\n"
else
    printf "\nInstalling LDAP backend...\n"
    (set -ex ; vault auth-enable ldap)
fi

printf "\nConfiguring LDAP backend...\n"
(set -ex; 
 vault write auth/ldap/config \
       url="ldap://localhost:3890" \
       userdn="ou=people,ou=someteam,ou=ad-someteam-dev,dc=ad-someteam-dev,dc=someorg,dc=io" \
       groupdn="OU=Groups,OU=someteam,OU=ad-someteam-dev,DC=ad-someteam-dev,DC=someorg,dc=io" \
       groupfilter="(&(objectclass=group)(cn=pg-dba)(member:1.2.840.113556.1.4.1941:={{.UserDN}}))" \
       groupattr="cn" \
       insecure_tls=true \
       starttls=false \
       binddn="cn=Administrator,cn=Users,dc=ad-someteam-dev,dc=someorg,dc=io" \
       bindpass="HeyH0Password")

printf "\nAdding default (empty) policy for LDAP group...\n"
(set -ex; vault write auth/ldap/groups/pg-dba policies=pg-dba)

printf "\nTesting Vault + AD integration via test login...\n"
(set -ex; vault auth -method=ldap username=vaultuser1 password=HeyH0Password)
