#!/bin/bash -x
set -x
role="${role}"

if [ "$role" == "cslbk" ]; then
function create_config {
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

export -f create_config

create_config > /etc/ansible/bootstrap.yml
# ansible-playbook bootstrap.yml
elif [ "$role" == "cslsd" ]; then
  echo "Need Consul Service Discovery Variables"
elif [ "$role" == "vault" ]; then
  echo "Need Vault Variables"
else
  echo "You suck at role association"
fi
