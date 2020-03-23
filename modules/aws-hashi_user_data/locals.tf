locals {
  serverinfo = merge(var.custom_serverinfo, var.serverinfo)
  snapshots  = merge(var.custom_snapshots, var.snapshots)
  consul_ports      = merge(var.custom_ports, var.consul_ports)
  vault_ports      = merge(var.custom_ports, var.vault_ports)
  tags       = merge(var.customtags, var.tags)
}
