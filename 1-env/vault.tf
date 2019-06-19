module "vault_sg" {
  source = "../modules/aws-security_group"
  create = "${var.vault["count"] >= 1 ? true : false}"

  name        = "vault_sg"
  description = "Security group vault"
  vpc_id      = "${var.vpc_id}"        # or use ${var.vpc_id} if there is an already defined network

  ingress_cidr_blocks = ["${var.mgmt_subnets}"]
  ingress_rules       = ["${split(",", var.vault["ingress_rules"])}", "${var.ingress_rules}"]
  egress_rules        = ["all-all"]

  tags = {
    client     = "${var.tags["client"]}"
    costcenter = "${var.tags["costcenter"]}"
  }
}

locals {
  vault_extra_tags = "${map("auto_join", var.vault["role"])}"
}

module "vault" {
  source          = "../modules/aws-createinstance"
  region          = "${var.region}"
  user_data       = "${module.hashi_user_data.user_data}"
  security_groups = "${module.vault_sg.this_security_group_id}"
  subnet_id       = "${var.subnet_id}"
  environment     = "${var.environment}"
  os_user         = "${var.os_user}"
  key_name        = "${var.key_name}"
  tags            = "${merge(var.tags, var.vault_extra_tags)}"
  serverinfo      = "${var.vault}"
  hostname        = "${lower(var.tags["client"])}-${var.vault["role"]}-srv"
}
