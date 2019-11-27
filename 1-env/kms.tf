module "kms" {
  source      = "../modules/aws-kms"
  snapshots   = var.snapshots
  name_prefix = lower(var.tags["client"])
  tags        = var.tags
  kmsinfo     = var.kms
}

