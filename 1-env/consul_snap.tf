module "consul_snap_sg" {
  source = "../modules/aws-security_group"
  create = "${var.consul_snap["count"] >= 1 ? true : false}"

  name        = "consulsnap_sg"
  description = "Security group consul service discovery"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks = ["${var.mgmt_subnets}"]
  ingress_rules       = ["${split(",", var.consul_snap["ingress_rules"])}", "${var.ingress_rules}"]
  egress_rules        = ["all-all"]

  tags = {
    client     = "${var.tags["client"]}"
    costcenter = "${var.tags["costcenter"]}"
  }
}

module "consul_snapshot_s3" {
  source = "../modules/aws-s3"

  serverinfo = "${var.consul_snap}"
  snapshots  = "${var.snapshots}"
  region     = "${var.region}"
  tags       = "${var.tags}"
}

module "consul_snapshot_user_data" {
  source = "../modules/aws-hashi_user_data"

  kms_key_id = "${module.kms.kms_id}"
  region     = "${var.region}"
  tags       = "${var.tags}"
  snapshots  = "${var.snapshots}"
  serverinfo = "${var.consul_snap}"
}

module "consul_snapshot" {
  source = "../modules/aws-asg"

  ami                  = "${data.aws_ami.consul.id}"
  user_data            = "${module.consul_snapshot_user_data.user_data}"
  security_groups      = ["${module.consul_snap_sg.this_security_group_id}"]
  iam_instance_profile = "${module.kms.iam_instance_profile}"
  subnet_id            = ["${var.subnet_id}"]
  key_name             = "${var.key_name}"
  tags                 = "${var.tags}"
  serverinfo           = "${var.consul_snap}"
  cluster_name         = "${lower(var.tags["client"])}-${var.environment}-${var.region}-${var.consul_snap["role"]}"
}
