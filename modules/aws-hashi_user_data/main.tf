data "template_file" "user_data" {
  template = "${file(var.user_data)}"

  vars = {
    role                    = "${var.serverinfo["role"]}"
    consul_bootstrap_expect = "${var.serverinfo["desired_capacity"]}"
    consul_datacenter       = "${var.serverinfo["datacenter"]}"
    consul_join_tag_value   = "${replace(var.tags["auto_join"], "AUTOJOIN", var.serverinfo["datacenter"])}"
    consul_join_region      = "${var.region}"
    consul_agent_is_server  = "${var.serverinfo["server"]}"
    consul_server_rpc_port  = "${var.ports["consulbk_server_rpc_port"]}"
    consul_serf_lan_port    = "${var.ports["consulbk_serf_lan_port"]}"
    consul_serf_wan_port    = "${var.ports["consulbk_serf_wan_port"]}"
    consul_http_port        = "${var.ports["consulbk_http_port"]}"
    consul_https_port       = "${var.ports["consulbk_https_port"]}"
    consul_dns_port         = "${var.ports["consulbk_dns_port"]}"
    consul_encryption_key   = "${var.serverinfo["masterkey"]}"
    vault_api_port          = "${var.ports["vault_api_port"]}"
    vault_cluster_port      = "${var.ports["vault_cluster_port"]}"
    vault_kms_key_id        = "${var.kms_key_id}"
    server_cert             = "${file(var.server_cert)}"
    server_key              = "${file(var.server_key)}"
    client_cert             = "${file(var.client_cert)}"
    client_key              = "${file(var.client_key)}"
    root_cert               = "${file(var.root_cert)}"
  }
}

data "template_cloudinit_config" "user_data" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.user_data.rendered}"
  }
}
