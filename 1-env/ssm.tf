module "ssm_data" {
  source    = "../modules/aws-ssm"
  region    = "${var.region}"
  join_tag  = "${var.vault["datacenter"]}"
  namespace = "${lower(var.tags["client"])}"
  key_id    = "${module.kms.kms_id}"

  # tags = "${var.tags}"
}
