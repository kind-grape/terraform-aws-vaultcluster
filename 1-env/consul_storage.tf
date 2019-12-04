module "consul_storage_sg" {
  source = "../modules/aws-security_group"
  create = local.consul_storage["count"] >= 1 ? true : false

  name        = "consul_storage_sg"
  description = "Security group consul storage"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = var.mgmt_subnets
  ingress_rules       = concat(split(",", local.consul_storage["ingress_rules"]), var.ingress_rules)
  egress_rules        = ["all-all"]

  tags = {
    client     = local.tags["client"]
    costcenter = local.tags["costcenter"]
  }
}

module "consul_storage_user_data" {
  source     = "../modules/aws-hashi_user_data"
  kms_key_id = module.kms.kms_id
  region     = var.region
  tags       = local.tags
  serverinfo = local.consul_storage
}

module "consul_storage" {
  source               = "../modules/aws-asg"
  ami                  = data.aws_ami.consul.id
  user_data            = module.consul_storage_user_data.user_data
  security_groups      = [module.consul_storage_sg.this_security_group_id]
  iam_instance_profile = module.kms.iam_instance_profile
  subnet_id            = split(",", var.subnet_id)
  key_name             = var.key_name
  tags                 = local.tags
  serverinfo           = local.consul_storage
  cluster_name         = "${lower(local.tags["client"])}-${var.environment}-${var.region}-${local.consul_storage["role"]}"
}
