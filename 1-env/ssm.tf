module "ssm_data" {
  source    = "../modules/aws-ssm"
  region    = "${var.region}"
  join_tag  = "${var.vault["datacenter"]}"
  namespace = "${lower(var.tags["client"])}"
}
