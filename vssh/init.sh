#!/bin/bash
#https://dickingwithdocker.com/2020/05/securing-ssh-with-the-vault-ssh-backend-and-github-authentication/
#https://github.com/organizations/plan
#https://github.com/settings/tokens
#
export VAULT_PATH="ssh-client"
vault secrets enable -path=${VAULT_PATH} ssh

vault write ${VAULT_PATH}/config/ca generate_signing_key=true
vault read -field=public_key ${VAULT_PATH}/config/ca > trusted-user-ca-keys.pem

vault policy write ssh-user ssh-user-policy.hcl

vault write ${VAULT_PATH}/roles/ssh-user @ssh-user-role.hcl

# check that this action completed successfully by querying the Vault API (there is no CLI command to do this):
# curl -s --header "X-Vault-Token: ${VAULT_TOKEN}" --request LIST https://${VAULT_ADDR}/v1/ssh-client/roles | jq .
#

export ORGNAME=ss7org
export TEAM=vssh
vault auth enable github
vault write auth/github/config organization=${ORGNAME}
vault write auth/github/map/teams/${TEAM} value=ssh-user

#Finally, in a different terminal, test out your access token to make sure you can log in:

#vault login -method=github token=${VAULT_GITHUB_TOKEN}
