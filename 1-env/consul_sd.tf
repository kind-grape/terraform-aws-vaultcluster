module "consulsd_sg" {
  source = "../modules/aws-security_group"
  create = "${var.consul_sd["count"] >= 1 ? true : false}"

  name        = "consulsd_sg"
  description = "Security group consul service discovery"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks = ["${var.mgmt_subnets}"]
  ingress_rules       = ["${split(",", var.consul_sd["ingress_rules"])}", "${var.ingress_rules}"]
  egress_rules        = ["all-all"]

  tags = {
    client     = "${var.tags["client"]}"
    costcenter = "${var.tags["costcenter"]}"
  }
}

module "consul_sd_user_data" {
  source     = "../modules/aws-hashi_user_data"
  user_data  = "${var.user_data}"
  kms_key_id = "${module.kms.kms_id}"
  region     = "${var.region}"
  ports      = "${var.ports}"
  tags       = "${var.tags}"
  serverinfo = "${var.consul_sd}"
}

module "consul_sd" {
  source               = "../modules/aws-asg"
  user_data            = "${module.consul_sd_user_data.user_data}"
  security_groups      = ["${module.consulsd_sg.this_security_group_id}"]
  iam_instance_profile = "${module.kms.iam_instance_profile}"
  subnet_id            = ["${var.subnet_id}"]
  key_name             = "${var.key_name}"
  tags                 = "${var.tags}"
  serverinfo           = "${var.consul_sd}"
  cluster_name         = "${lower(var.tags["client"])}-${var.environment}-${var.region}-${var.consul_sd["role"]}"
}
