data "template_file" "user_data" {
  template = "${file(var.user_data)}"

  vars = {
    role                    = "${var.serverinfo["role"]}"
    consul_bootstrap_expect = "${var.serverinfo["desired_capacity"]}"
    consul_datacenter       = "${var.serverinfo["datacenter"]}"
    consul_join_tag_value   = "${replace(var.tags["auto_join"], "AUTOJOIN", var.serverinfo["datacenter"])}"
    consul_join_region      = "${var.region}"
    consul_agent_is_server  = "${var.serverinfo["server"]}"
    consul_unbound          = "${var.serverinfo["unbound"]}"
    consul_dnsmasq          = "${var.serverinfo["dnsmasq"]}"
    consul_https_enabled    = "${var.serverinfo["https"]}"
    consul_bucket_name      = "${var.snapshots["bucket_name"]}"
    consul_snapshot_name    = "${var.snapshots["snapshot_name"]}"
    consul_server_rpc_port  = "${var.ports["consulbk_server_rpc_port"]}"
    consul_serf_lan_port    = "${var.ports["consulbk_serf_lan_port"]}"
    consul_serf_wan_port    = "${var.ports["consulbk_serf_wan_port"]}"
    consul_http_port        = "${var.ports["consulbk_http_port"]}"
    consul_https_port       = "${var.ports["consulbk_https_port"]}"
    consul_dns_port         = "${var.ports["consulbk_dns_port"]}"
    vault_unseal            = "${var.vault_unseal}"
    vault_api_port          = "${var.ports["vault_api_port"]}"
    vault_cluster_port      = "${var.ports["vault_cluster_port"]}"
    vault_https_enabled     = "${var.serverinfo["tlslistener"]}"
    vault_telemtry_enabled  = "${var.vault_telemetry}"
    unseal_cloud            = "${var.unseal_cloud}"
    vault_kms_key_id        = "${var.kms_key_id}"
  }
}

data "template_cloudinit_config" "user_data" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.user_data.rendered}"
  }
}
