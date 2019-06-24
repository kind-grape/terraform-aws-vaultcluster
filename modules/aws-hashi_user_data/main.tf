data "template_file" "user_data" {
  template = "${file(var.user_data)}"
  vars = {
    role = "${var.serverinfo["role"]}"
    consul_bootstrap_expect = "${var.serverinfo["desired_capacity"]}"
    consul_datacenter = "${var.serverinfo["datacenter"]}"
    consul_join_tag_value = "${replace(var.tags["auto_join"], "AUTOJOIN", var.serverinfo["datacenter"])}"
    consul_join_region = "${var.region}"
    consul_agent_is_server = "${var.serverinfo["server"]}"
    consul_server_rpc_port = "${var.ports["consulbk_server_rpc_port"]}"
    consul_serf_lan_port = "${var.ports["consulbk_serf_lan_port"]}"
    consul_serf_wan_port = "${var.ports["consulbk_serf_wan_port"]}"
    consul_http_port = "${var.ports["consulbk_http_port"]}"
    consul_https_port = "${var.ports["consulbk_https_port"]}"
    consul_dns_port = "${var.ports["consulbk_dns_port"]}"
    consul_encryption_key = "${var.serverinfo["masterkey"]}"
  }
}
