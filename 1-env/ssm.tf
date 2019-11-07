module "ssm_data" {
  source        = "../modules/aws-ssm"
  region        = "${var.region}"
  join_tag      = "${var.vault["datacenter"]}"
  https_enabled = "${var.vault["tlslistener"]}"
  namespace     = "${lower(var.tags["client"])}"
  key_id        = "${module.kms.kms_id}"
}
