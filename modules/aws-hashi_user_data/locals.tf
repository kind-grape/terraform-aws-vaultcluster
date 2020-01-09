locals {
  serverinfo = merge(var.custom_serverinfo, var.serverinfo)
  snapshots  = merge(var.custom_snapshots, var.snapshots)
  ports      = merge(var.custom_ports, var.ports)
  tags       = merge(var.customtags, var.tags)
}
