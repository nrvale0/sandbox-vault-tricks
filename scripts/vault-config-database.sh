#!/bin/bash

set -u

export VAULT_ADDR="http://127.0.0.1:8200/"

clear

printf "\nMounting Vault database backend..."
(set -x; vault mount database)

printf "\nWriting the Postgres database backend config..."
(set -x; 
	vault write database/config/postgresql plugin_name=postgresql-database-plugin allowed_roles="readonly" connection_url="postgresql://postgres:postgres@postgres:5432/testdb?sslmode=disable")

printf "\nCreating a read-only policy to associate with credentials..."
(set -x; 
	vault write database/roles/readonly \
		db_name=postgresql \
		creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; \
		GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
		default_ttl="30m" \
    		max_ttl="1h")

printf "\nRead the read-only account credentials..."
(set -x ; vault read database/creds/readonly)
