module "vault_sg" {
  source = "../modules/aws-security_group"
  create = "${var.vault["count"] >= 1 ? true : false}"

  name        = "vault_sg"
  description = "Security group vault"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks = ["${var.mgmt_subnets}"]
  ingress_rules       = ["${split(",", var.vault["ingress_rules"])}", "${var.ingress_rules}"]
  egress_rules        = ["all-all"]

  tags = {
    client     = "${var.tags["client"]}"
    costcenter = "${var.tags["costcenter"]}"
  }
}

module "vault_user_data" {
  source       = "../modules/aws-hashi_user_data"
  kms_key_id   = "${module.kms.kms_id}"
  vault_unseal = "${var.vault_unseal}"
  region       = "${var.region}"
  tags         = "${var.tags}"
  serverinfo   = "${var.vault}"
}

module "vault" {
  source               = "../modules/aws-createinstance"
  ami                  = "${data.aws_ami.vault.id}"
  user_data            = "${module.vault_user_data.user_data}"
  security_groups      = "${module.vault_sg.this_security_group_id}"
  iam_instance_profile = "${module.kms.iam_instance_profile}"
  subnet_id            = "${var.subnet_id}"
  key_name             = "${var.key_name}"
  tags                 = "${var.tags}"
  serverinfo           = "${var.vault}"
  hostname             = "${lower(var.tags["client"])}-${var.environment}-${var.region}-${var.vault["role"]}"
}
