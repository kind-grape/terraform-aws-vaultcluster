locals {
  consul_sd = merge(var.custom_consul_snap, var.consul_sd)
  consul_storage = merge(var.custom_consul_storage, var.consul_storage)
  vault = merge(var.custom_vault, var.vault)
  consul_snap = merge(var.custom_consul_snap, var.consul_snap)
  tags = merge(var.customtags, var.tags)
}
