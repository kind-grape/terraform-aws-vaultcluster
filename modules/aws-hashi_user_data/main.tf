data "template_file" "user_data" {
  template = file(var.user_data)

  vars = {
    role                    = local.serverinfo["role"]
    consul_bootstrap_expect = local.serverinfo["desired_capacity"]
    consul_datacenter       = local.serverinfo["datacenter"]
    consul_join_tag_value = replace(
      local.tags["auto_join"],
      "AUTOJOIN",
      local.serverinfo["datacenter"],
    )
    consul_join_region       = var.region
    consul_agent_is_server   = local.serverinfo["server"]
    consul_unbound           = local.serverinfo["unbound"]
    consul_dnsmasq           = local.serverinfo["dnsmasq"]
    consul_https_enabled     = local.serverinfo["https"]
    consul_bucket_name       = local.snapshots["bucket_name"]
    consul_snapshot_name     = local.snapshots["snapshot_name"]
    consul_server_rpc_port   = local.ports["consulbk_server_rpc_port"]
    consul_serf_lan_port     = local.ports["consulbk_serf_lan_port"]
    consul_serf_wan_port     = local.ports["consulbk_serf_wan_port"]
    consul_http_port         = local.ports["consulbk_http_port"]
    consul_https_port        = local.ports["consulbk_https_port"]
    consul_dns_port          = local.ports["consulbk_dns_port"]
    vault_unseal             = var.vault_unseal
    vault_api_port           = local.ports["vault_api_port"]
    vault_cluster_port       = local.ports["vault_cluster_port"]
    vault_https_enabled      = local.serverinfo["tlslistener"]
    bootstrap                = var.bootstrap
    cloud_env                = var.cloud_env
    vault_telemtry_enabled   = var.vault_telemetry
    vault_recovery_shares    = var.vault_recovery_shares
    vault_recovery_threshold = var.vault_recovery_threshold
    unseal_cloud             = var.unseal_cloud
    vault_kms_key_id         = var.kms_key_id
  }
}

data "template_cloudinit_config" "user_data" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.user_data.rendered
  }
}
