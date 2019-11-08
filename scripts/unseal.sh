#!/usr/bin/env bash
set -x
export PATH=$PATH:/tmp
<% if @enterprise == true -%>
export UNSEAL="vault operator init -recovery-shares=5 -recovery-threshold=3"
<% else -%>
export UNSEAL="vault operator init"
<% end -%>
<% if @tlslistener == true -%>
export VAULT_ADDR='https://127.0.0.1:8200'
<% else -%>
export VAULT_ADDR='http://127.0.0.1:8200'
<% end -%>

if [ ! -f "/tmp/vault.txt" ]; then
	$UNSEAL | tee /tmp/vault.txt 2>&1
fi

if [ ! -f "/tmp/vault_unseal.txt" ]; then
<% if @enterprise == true -%>
	cat /tmp/vault.txt | grep "^Recovery Key" | awk '{ print $4 }' 2>&1 | tee /tmp/vault_unseal.txt
<% else -%>
	cat /tmp/vault.txt | grep "^Unseal Key" | awk '{ print $4 }' 2>&1 | tee /tmp/vault_unseal.txt
<% end -%>
fi

if [ ! -f "/tmp/vault_root_key.txt" ]; then
	cat /tmp/vault.txt | grep "^Initial Root" | awk '{ print $4 }' 2>&1 | tee /tmp/vault_root_key.txt
fi

<% if @enterprise != true -%>
## Unseal if KMS not used
head -3 /tmp/vault_unseal.txt | while read a; do vault operator unseal $a; done
<% end -%>

if [ ! -f "/tmp/vault_admin_key.txt" ]; then
vault login $(cat /tmp/vault_root_key.txt)
function hcl {
cat <<- _EOF_
path "*" { capabilities = [ "read", "create", "update", "delete", "sudo", "list" ] }
_EOF_
}
export -f hcl
hcl > /tmp/admin.hcl
vault policy write admin /tmp/admin.hcl
vault token create -orphan -policy=admin | grep "^token\b" | awk '{ print $2 }' 2>&1 | tee /tmp/vault_admin_key.txt
# vault token revoke -self
fi

# vault login $(cat /tmp/vault_admin_key.txt)
