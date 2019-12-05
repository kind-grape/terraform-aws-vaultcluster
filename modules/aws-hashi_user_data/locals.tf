locals {
  serverinfo = merge(var.custom_serverinfo, var.serverinfo)
  snapshots = merge(var.custom_snapshots, var.snapshots)
  tags = merge(var.customtags, var.tags)
}
