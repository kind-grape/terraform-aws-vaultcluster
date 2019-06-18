module "consulbk_sg" {
  source = "../modules/aws-security_group"
  create = "${var.consul_bk["count"] >= 1 ? true : false}"

  name        = "consulbk_sg"
  description = "Security group consul backend"
  vpc_id      = "${var.vpc_id}"                 # or use ${var.vpc_id} if there is an already defined network

  ingress_cidr_blocks = ["${var.mgmt_subnets}"]
  ingress_rules       = ["${split(",", var.consul_bk["ingress_rules"])}", "${var.ingress_rules}"]
  egress_rules        = ["all-all"]

  tags = {
    client     = "${var.tags["client"]}"
    costcenter = "${var.tags["costcenter"]}"
  }
}

module "consul_bk" {
  source          = "../modules/aws-createinstance"
  ssh_public_key  = "${file(var.ssh_public_key_location)}"
  region          = "${var.region}"
  security_groups = "${module.consulbk_sg.this_security_group_id}"
  subnet_id       = "${var.subnet_id}"
  environment     = "${var.environment}"
  os_user         = "${var.os_user}"
  key_name        = "${var.key_name}"
  tags            = "${var.tags}"
  serverinfo      = "${var.consul_bk}"
  hostname        = "${lower(var.tags["client"])}-${var.consul_bk["role"]}-srv"
}
