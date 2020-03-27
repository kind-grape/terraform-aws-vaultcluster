module "kms" {
  source      = "../modules/aws-kms"
  snapshots   = local.snapshots
  name_prefix = lower(var.tags["client"])
  tags        = var.tags
  kmsinfo     = var.kms
  ami_owner_account = var.ami_owner_account
}
