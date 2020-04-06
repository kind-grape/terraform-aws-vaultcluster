#Demote the original DR primary cluster to a secondary
 vault write -f sys/replication/dr/primary/demote


##To make Secondary Connect to new Primary  without wiping
## Will create nonce and otp
vault operator generate-root -dr-token -init

#Use generate nonce key and unseal keys from LastPoass need at least 3 unseal keys
vault operator generate-root -dr-token -nonce="<nonce>" <primary_unseal_key_1>

#Will Generate DR Token from encoded token and otp
vault operator generate-root -dr-token -decode="<encoded_token" -otp="<otp>"

#Use generated dr-token and copy replication token from primary.
vault write sys/replication/dr/secondary/update-primary dr_operation_token="<dr_token>" token="<replication_secondary_token>"
