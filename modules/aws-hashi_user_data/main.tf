data "template_file" "user_data" {
  # count    = "${var.serverinfo["count"] >= 1 ? 1 : 0}"
  template = "${file(var.user_data)}"
  vars = {
    role = "${var.serverinfo["role"]}"
    consul_bootstrap_expect = "${var.serverinfo["count"]}"
    consul_join_tag_value = "${replace(var.tags["auto_join"], "AUTOJOIN", var.serverinfo["role"])}"
    consul_join_region = "${var.region}"
    consul_server_rpc_port = "${var.ports["consulbk_server_rpc_port"]}"
    consul_serf_lan_port = "${var.ports["consulbk_serf_lan_port"]}"
    consul_serf_wan_port = "${var.ports["consulbk_serf_wan_port"]}"
    consul_http_port = "${var.ports["consulbk_http_port"]}"
    consul_https_port = "${var.ports["consulbk_https_port"]}"
    consul_dns_port = "${var.ports["consulbk_dns_port"]}"
    consul_encryption_key = "${var.serverinfo["masterkey"]}"
    consul_agent_policy_name = "consul-agent-0"
    consul_application_policy_name = "vault-agent-0"
  }
}
