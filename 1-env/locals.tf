locals {
  consul_sd      = merge(var.custom_consul_sd, var.consul_sd)
  consul_storage = merge(var.custom_consul_storage, var.consul_storage)
  vault          = merge(var.custom_vault, var.vault)
  consul_snap    = merge(var.custom_consul_snap, var.consul_snap)
  mgmt_subnets   = concat(split(",", var.subnets["public"]), split(",", var.subnets["private"]), var.mgmt_subnets)
  certs          = merge(var.example_cert, var.certs)
  tags           = merge(var.customtags, var.tags)
}
