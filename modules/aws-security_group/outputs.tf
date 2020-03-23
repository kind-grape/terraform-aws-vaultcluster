output "this_security_group_id" {
  description = "The ID of the security group"
  value = concat(
    aws_security_group.this.*.id,
    aws_security_group.this_name_prefix.*.id,
    [""],
  )[0]
}

output "this_security_group_vpc_id" {
  description = "The VPC ID"
  value = concat(
    aws_security_group.this.*.vpc_id,
    aws_security_group.this_name_prefix.*.vpc_id,
    [""],
  )[0]
}

output "this_security_group_owner_id" {
  description = "The owner ID"
  value = concat(
    aws_security_group.this.*.owner_id,
    aws_security_group.this_name_prefix.*.owner_id,
    [""],
  )[0]
}

output "this_security_group_name" {
  description = "The name of the security group"
  value = concat(
    aws_security_group.this.*.name,
    aws_security_group.this_name_prefix.*.name,
    [""],
  )[0]
}

output "this_security_group_description" {
  description = "The description of the security group"
  value = concat(
    aws_security_group.this.*.description,
    aws_security_group.this_name_prefix.*.description,
    [""],
  )[0]
}

output "vault_ports" {
  description = "Ports for Vault based on Ingress rules"
  value = {
    vault_api_port = var.rules["vault-tcp"][0]
    vault_cluster_port = var.rules["vault-cluster-tcp"][0]
  }
}
output "consul_ports" {
  description = "Ports for Consul based on Ingress rules"
  value = {
    consul_server_rpc_port = contains(var.ingress_rules, "consulbk-tcp") ? var.rules["consulbk-tcp"][0] : var.rules["consul-tcp"][0]
    consul_serf_lan_port   = contains(var.ingress_rules, "consulbk-serf-lan-tcp") ? var.rules["consulbk-serf-lan-tcp"][0] : var.rules["consul-serf-lan-tcp"][0]
    consul_serf_wan_port   = contains(var.ingress_rules, "consulbk-serf-wan-tcp") ? var.rules["consulbk-serf-wan-tcp"][0] : var.rules["consul-serf-wan-tcp"][0]
    consul_http_port       = contains(var.ingress_rules, "consulbk-webui-tcp") ? var.rules["consulbk-webui-tcp"][0] : var.rules["consul-webui-tcp"][0]
    consul_https_port      = contains(var.ingress_rules, "consulbk-webuis-tcp") ? var.rules["consulbk-webuis-tcp"][0] : var.rules["consul-webuis-tcp"][0]
    consul_dns_port        = contains(var.ingress_rules, "consulbk-dns-tcp") ? var.rules["consulbk-dns-tcp"][0] : var.rules["consul-dns-tcp"][0]
  }
}
