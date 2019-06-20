#!/bin/bash -x
set -x
role="${role}"

function create_consul_config {
cat <<- _EOF_
- hosts: localhost
  become: yes
  vars:
    consul_bootstrap_expect: ${consul_bootstrap_expect}
    consul_join_tag_key: auto_join
    consul_join_tag_value: ${consul_join_tag_value}
    consul_join_region: ${consul_join_region}
    consul_agent_role: server
    consul_server_rpc_port: ${consul_server_rpc_port}
    consul_serf_lan_port: ${consul_serf_lan_port}
    consul_serf_wan_port: ${consul_serf_wan_port}
    consul_http_port: ${consul_http_port}
    consul_https_port: ${consul_https_port}
    consul_dns_port: ${consul_dns_port}
    consul_encryption_key: ${consul_encryption_key}
    consul_agent_policy_name: ${consul_agent_policy_name}
    consul_application_policy_name: ${consul_application_policy_name}

  roles:
    - consul-agent
_EOF_
}

function create_cert {
cat <<- _EOF_
-----BEGIN CERTIFICATE-----
MIIDbTCCAxOgAwIBAgIQUuG4iJASQcomQfEQOoZQUjAKBggqhkjOPQQDAjCBuTEL
MAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRYwFAYDVQQHEw1TYW4gRnJhbmNpc2Nv
MRowGAYDVQQJExExMDEgU2Vjb25kIFN0cmVldDEOMAwGA1UEERMFOTQxMDUxFzAV
BgNVBAoTDkhhc2hpQ29ycCBJbmMuMUAwPgYDVQQDEzdDb25zdWwgQWdlbnQgQ0Eg
MTEwMTY4NzA1MjMwNTE4NTI0NDAzNjg2NjUxNzY5OTg5MjU1MjUwMB4XDTE5MDYy
MDE1NDU0N1oXDTI0MDYxODE1NDU0N1owgbkxCzAJBgNVBAYTAlVTMQswCQYDVQQI
EwJDQTEWMBQGA1UEBxMNU2FuIEZyYW5jaXNjbzEaMBgGA1UECRMRMTAxIFNlY29u
ZCBTdHJlZXQxDjAMBgNVBBETBTk0MTA1MRcwFQYDVQQKEw5IYXNoaUNvcnAgSW5j
LjFAMD4GA1UEAxM3Q29uc3VsIEFnZW50IENBIDExMDE2ODcwNTIzMDUxODUyNDQw
MzY4NjY1MTc2OTk4OTI1NTI1MDBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABGgf
3AygHU/Yd6bm4sVx3a2HMoiUnQtf6HJENf8Pqcl+sBesIs1p9aveOelqiWIv6bHa
2Wj0FXBDWr0P3zHrLvajgfowgfcwDgYDVR0PAQH/BAQDAgGGMA8GA1UdEwEB/wQF
MAMBAf8waAYDVR0OBGEEXzkzOjZkOjRhOjI4OjNlOmQ1Ojg1OjRmOjI4OjVlOmUw
OmJjOmRjOmJhOjIwOmFmOjE3Ojc5OmQwOjk0OmM2OmI3OmRhOjRmOmQzOjA4Ojgz
OjdmOmFmOmYxOjljOjMwMGoGA1UdIwRjMGGAXzkzOjZkOjRhOjI4OjNlOmQ1Ojg1
OjRmOjI4OjVlOmUwOmJjOmRjOmJhOjIwOmFmOjE3Ojc5OmQwOjk0OmM2OmI3OmRh
OjRmOmQzOjA4OjgzOjdmOmFmOmYxOjljOjMwMAoGCCqGSM49BAMCA0gAMEUCIDU/
rZv3P3OBmKQGYFs3Bb8iJ+andLkKHx2f8AGcPBfXAiEAvc3WC1isJ2b+rKIMhZVA
9H278pN5joEg3vWbwb6evRE=
-----END CERTIFICATE-----
_EOF_
}

function create_cert_client {
cat <<- _EOF_
-----BEGIN CERTIFICATE-----
MIIDHTCCAsOgAwIBAgIRAPQ1qrg2JBHESib1VF+/w2swCgYIKoZIzj0EAwIwgbkx
CzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEWMBQGA1UEBxMNU2FuIEZyYW5jaXNj
bzEaMBgGA1UECRMRMTAxIFNlY29uZCBTdHJlZXQxDjAMBgNVBBETBTk0MTA1MRcw
FQYDVQQKEw5IYXNoaUNvcnAgSW5jLjFAMD4GA1UEAxM3Q29uc3VsIEFnZW50IENB
IDExMDE2ODcwNTIzMDUxODUyNDQwMzY4NjY1MTc2OTk4OTI1NTI1MDAeFw0xOTA2
MjAxNTQ2MTFaFw0yMDA2MTkxNTQ2MTFaMBwxGjAYBgNVBAMTEWNsaWVudC5kYzEu
Y29uc3VsMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEYOdEjRfEahRWwFbRunFI
5vQkHoBIBpDg+JLp7A1pdeyceJepoINFPfzWlhFCdf6yZv1qRorX7sqg9peF3ZVA
DqOCAUYwggFCMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDAgYI
KwYBBQUHAwEwDAYDVR0TAQH/BAIwADBoBgNVHQ4EYQRfYTY6ZDg6ZGY6NTA6N2Q6
MWU6MDU6N2Q6MjI6NjE6NDM6Mjk6NmQ6MzM6ZTA6Yjk6ZDE6YzU6YWU6NTY6YzM6
YjI6NjE6MTM6MWE6M2U6OGM6NjQ6NzA6NzM6OWQ6NGEwagYDVR0jBGMwYYBfOTM6
NmQ6NGE6Mjg6M2U6ZDU6ODU6NGY6Mjg6NWU6ZTA6YmM6ZGM6YmE6MjA6YWY6MTc6
Nzk6ZDA6OTQ6YzY6Yjc6ZGE6NGY6ZDM6MDg6ODM6N2Y6YWY6ZjE6OWM6MzAwLQYD
VR0RBCYwJIIRY2xpZW50LmRjMS5jb25zdWyCCWxvY2FsaG9zdIcEfwAAATAKBggq
hkjOPQQDAgNIADBFAiEAuh4MMoY4NNOEFX1m7Io5cQ/vgC/EDEbMrjZpmif64Z4C
IFOC//ougZEsDeOKAg/Qw34miLMAjpAlpa3fCIdXkDSf
-----END CERTIFICATE-----
_EOF_
}

function create_cert_client_key {
cat <<- _EOF_
-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIIDdsU8HBzLx6T08F4hfBSgkeCmHHJ95QrO1EEDQTguroAoGCCqGSM49
AwEHoUQDQgAEYOdEjRfEahRWwFbRunFI5vQkHoBIBpDg+JLp7A1pdeyceJepoINF
PfzWlhFCdf6yZv1qRorX7sqg9peF3ZVADg==
-----END EC PRIVATE KEY-----
_EOF_
}

function create_cert_server {
cat <<- _EOF_
-----BEGIN CERTIFICATE-----
MIIDHjCCAsOgAwIBAgIRANSHJSecsbyffC6KgAda2GowCgYIKoZIzj0EAwIwgbkx
CzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEWMBQGA1UEBxMNU2FuIEZyYW5jaXNj
bzEaMBgGA1UECRMRMTAxIFNlY29uZCBTdHJlZXQxDjAMBgNVBBETBTk0MTA1MRcw
FQYDVQQKEw5IYXNoaUNvcnAgSW5jLjFAMD4GA1UEAxM3Q29uc3VsIEFnZW50IENB
IDExMDE2ODcwNTIzMDUxODUyNDQwMzY4NjY1MTc2OTk4OTI1NTI1MDAeFw0xOTA2
MjAxNTQ2MDhaFw0yMDA2MTkxNTQ2MDhaMBwxGjAYBgNVBAMTEXNlcnZlci5kYzEu
Y29uc3VsMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEN0shE2bZ8zko4Bxg9Bub
ZJVt1dFxCrYP5VNK9wt3TQjB2j9wXaZyjyuUkAbpPf83A0p9UI1ZKpUjmycZGnhZ
DKOCAUYwggFCMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDAQYI
KwYBBQUHAwIwDAYDVR0TAQH/BAIwADBoBgNVHQ4EYQRfZjE6Zjk6YjQ6ZTA6MmQ6
NTQ6Mjc6YzQ6OTg6ODU6ZDk6NmU6M2U6MTY6ZGI6ZjA6M2E6ZWU6YTc6ZmM6MWM6
YWY6YmI6OGY6MDk6NGY6Yzk6Njk6ZjQ6NjA6MjE6N2EwagYDVR0jBGMwYYBfOTM6
NmQ6NGE6Mjg6M2U6ZDU6ODU6NGY6Mjg6NWU6ZTA6YmM6ZGM6YmE6MjA6YWY6MTc6
Nzk6ZDA6OTQ6YzY6Yjc6ZGE6NGY6ZDM6MDg6ODM6N2Y6YWY6ZjE6OWM6MzAwLQYD
VR0RBCYwJIIRc2VydmVyLmRjMS5jb25zdWyCCWxvY2FsaG9zdIcEfwAAATAKBggq
hkjOPQQDAgNJADBGAiEAxmuS7a1LJt4NyFU0QF1OjWd1bhN4WFJHAIxroCMp1RUC
IQD19P/+oZ4FCD8+C4sPwn0V5i/yOPWv1urHQ8GCgKmUpg==
-----END CERTIFICATE-----
_EOF_
}

function create_cert_server_key {
cat <<- _EOF_
-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIBPOV4dm1NS6jsxYCSGg8s/5rWfJPfiTrviyazghDRmWoAoGCCqGSM49
AwEHoUQDQgAEN0shE2bZ8zko4Bxg9BubZJVt1dFxCrYP5VNK9wt3TQjB2j9wXaZy
jyuUkAbpPf83A0p9UI1ZKpUjmycZGnhZDA==
-----END EC PRIVATE KEY-----
_EOF_
}

export -f create_consul_config; export -f create_cert; export -f create_cert_client; export -f create_cert_client_key; export -f create_cert_server; export -f create_cert_server_key

if [ "$role" == "cslstore" ]; then

cert_dir="/etc/$role-ansible/roles/$role-agent/files/etc/$role.d/tls"
create_cert > $cert_dir/$role-agent-ca.pem
create_cert_client > $cert_dir/dc1-client-$role-0.pem
create_cert_client_key > $cert_dir/dc1-client-$role-0-key.pem
create_cert_server > $cert_dir/dc1-server-$role-0.pem
create_cert_server_key > $cert_dir/dc1-server-$role-0-key.pem

create_consul_config > /etc/$role-ansible/bootstrap.yml
ansible-playbook /etc/$role-ansible/bootstrap.yml
elif [ "$role" == "cslsd" ]; then
  echo "Need Consul Service Discovery Variables"
elif [ "$role" == "vault" ]; then
  create_consul_config > /etc/$role-ansible/bootstrap.yml
  ansible-playbook /etc/$role-ansible/bootstrap.yml
else
  echo "You suck at role association"
fi
