module "kms" {
  source              = "../modules/aws-kms"
  name_prefix         = "${lower(var.tags["client"])}"
  // region              = "${var.region}"
  // environment         = "${var.environment}"
  tags                = "${var.tags}"
  kmsinfo             = "${var.kms}"
}
