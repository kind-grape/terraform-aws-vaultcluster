locals {
  serverinfo = merge(var.custom_serverinfo, var.serverinfo)
  tags = merge(var.customtags, var.tags)
}
