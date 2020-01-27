locals {
  consul_sd      = merge(var.custom_consul_sd, var.consul_sd)
  consul_storage = merge(var.custom_consul_storage, var.consul_storage)
  vault          = merge(var.custom_vault, var.vault)
  consul_snap    = merge(var.custom_consul_snap, var.consul_snap)
  snapshots    = merge(var.custom_snapshots, var.snapshots)
  ports          = merge(var.custom_ports, var.ports)
  mgmt_subnets   = concat(var.mgmt_subnets, [var.address_space])
  certs          = merge(var.example_cert, var.certs)
  tags           = merge(var.customtags, var.tags)
}
