#!/bin/bash

set -u

: ${VAULT_ADDR:="http://127.0.0.1:8200"}

clear

printf "\nMounting Vault database backend...\n"
(set -x; vault mount database)

printf "\nWriting the Postgres database backend config...\n"
(set -x; 
	vault write database/config/postgresql plugin_name=postgresql-database-plugin allowed_roles="readonly,writeall" connection_url="postgresql://postgres:postgres@postgres:5432/testdb?sslmode=disable")

printf "\nCreating a read-only policy which has read-only access to all tables in public schema on 'testdb'...\n"
(set -x; 
	vault write database/roles/readonly \
		db_name=postgresql \
		creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; \
		GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
		default_ttl="30m" \
    		max_ttl="1h")

printf "\nCreating a writeall role which can write to all tables in public schema on 'testdb'...\n"
(set -x; 
	vault write database/roles/writeall \
		db_name=postgresql \
		creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; \
		GRANT ALL ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
		default_ttl="30m" \
    		max_ttl="1h")

printf "\nRead the read-only account credentials...\n"
(set -x ; vault read database/creds/readonly)

printf "\nRead the write-all account credentials...\n"
(set -x ; vault read database/creds/writeall)
