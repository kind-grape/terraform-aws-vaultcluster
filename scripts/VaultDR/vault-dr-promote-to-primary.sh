## Will create nonce and otp
vault operator generate-root -dr-token -init

#Use generate nonce key and unseal keys from LastPoass need at least 3 unseal keys
vault operator generate-root -dr-token -nonce="<nonce>" <primary_unseal_key_1>

#Will Generate DR Token from encoded token and otp
vault operator generate-root -dr-token -decode="<encoded_token" -otp="<otp>"

#Promote the DR secondary to become the primary. The request must pass the DR operation token that was generated with previous command.
vault write /sys/replication/dr/secondary/promote dr_operation_token="<dr_token>"
