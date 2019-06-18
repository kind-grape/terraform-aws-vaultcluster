module "kms" {
  source      = "../modules/aws-kms"
  name_prefix = "${lower(var.tags["client"])}"
  tags        = "${var.tags}"
  kmsinfo     = "${var.kms}"
}
