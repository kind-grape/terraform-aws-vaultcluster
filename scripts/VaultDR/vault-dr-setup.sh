##Enable DR replication on the primary cluster.
#vault write -f sys/replication/dr/primary/enable
curl --header "X-Vault-Token: $VAULT_TOKEN" \
      --request POST \
      --data '{}' \
      https://internal-aor-prod-vault-secretagent-128117863.us-west-2.elb.amazonaws.com/v1/sys/replication/dr/primary/enable -k

##Generate a secondary token.
#vault write sys/replication/dr/primary/secondary-token id="vault-ava-us-east-1"
curl --header "X-Vault-Token: $VAULT_TOKEN" \
      --request POST \
      --data '{ "id": "vault-ava-us-east-1"}' \
      https://internal-aor-prod-vault-secretagent-128117863.us-west-2.elb.amazonaws.com/v1/sys/replication/dr/primary/secondary-token -k| jq -r '.wrap_info' | jq  'del(.accessor, .ttl, .creation_time, .creation_path)' > secondary_token.json

##Copy the generated wrapping_token which you will need to enable the DR secondary cluster.
##Enable DR Secondary Replication


##Enable DR Replication on Secondary Cluster
#vault write sys/replication/dr/secondary/enable token="SECONDARY_TOKEN"

curl --header "X-Vault-Token: $VAULT_TOKEN" \
      --request POST \
      --data @secondary_token.json \
      https://internal-ava-prod-vault-secretagent-70586122.us-east-1.elb.amazonaws.com/v1/sys/replication/dr/secondary/enable -k | jq


#Connect Secodary Vault to Primary
vault write /sys/replication/dr/secondary/update-primary token="SECONDARY_TOKEN"
