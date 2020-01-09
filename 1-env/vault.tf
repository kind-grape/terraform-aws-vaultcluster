module "vault_sg" {
  source = "../modules/aws-security_group"
  create = local.vault["count"] >= 1 ? true : false

  name        = "vault_sg"
  description = "Security group vault"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = local.mgmt_subnets
  ingress_rules       = concat(split(",", local.vault["ingress_rules"]), var.ingress_rules)
  egress_rules        = ["all-all"]

  tags = {
    client     = local.tags["client"]
    costcenter = local.tags["costcenter"]
  }
}

module "vault_user_data" {
  source     = "../modules/aws-hashi_user_data"
  kms_key_id = module.kms.kms_id
  region     = var.region
  tags       = local.tags
  serverinfo = local.vault
  ports      = local.ports
}

module "vault" {
  source               = "../modules/aws-asg"
  ami                  = data.aws_ami.vault.id
  user_data            = module.vault_user_data.user_data
  security_groups      = [module.vault_sg.this_security_group_id]
  iam_instance_profile = module.kms.iam_instance_profile
  subnet_id            = split(",", var.subnet_id)
  key_name             = var.key_name
  tags                 = local.tags
  serverinfo           = local.vault
  cluster_name         = "${lower(local.tags["client"])}-${var.environment}-${var.region}-${local.vault["role"]}"
}
