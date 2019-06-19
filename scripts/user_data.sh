#!/bin/bash -x
set -x

function create_config {
cat <<- _EOF_
{% if role == 'consulbk' %}
- hosts: tag_Name_consul_storage_novel_yak
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
{% else %}
roles:
  - vault-agent
{% endif %}
_EOF_
}

export -f create_config

{% if role == 'consulbk' %}
create_config > /tmp/consul-ansible/boostrap.yml
{% else %}

{% endif %}
