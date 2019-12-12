locals {
  kmsinfo = merge(var.custom_kmsinfo, var.kmsinfo)
  tags = merge(var.custom_tags, var.tags)
}
