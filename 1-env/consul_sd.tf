module "consulsd_sg" {
  source = "../modules/aws-security_group"
  create = local.consul_sd["count"] >= 1 ? true : false

  name        = "consulsd_sg"
  description = "Security group consul service discovery"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = local.mgmt_subnets
  ingress_rules       = concat(var.ingress_rules, split(",", local.consul_sd["ingress_rules"]))
  egress_rules        = ["all-all"]

  tags = {
    client     = local.tags["client"]
    costcenter = local.tags["costcenter"]
  }
}

module "consul_sd_user_data" {
  source     = "../modules/aws-hashi_user_data"
  
  kms_key_id = module.kms.kms_id
  region     = var.region
  tags       = local.tags
  serverinfo = local.consul_sd
  ports      = local.ports
  bootstrap  = var.bootstrap # true or false
}

module "consul_sd" {
  source               = "../modules/aws-asg"
  ami                  = data.aws_ami.consul.id
  user_data            = module.consul_sd_user_data.user_data
  security_groups      = [module.consulsd_sg.this_security_group_id]
  iam_instance_profile = module.kms.iam_instance_profile
  subnet_id            = split(",", var.subnet_id)
  key_name             = var.key_name
  tags                 = local.tags
  serverinfo           = local.consul_sd
  cluster_name         = "${lower(local.tags["client"])}-${var.environment}-${var.region}-${local.consul_sd["role"]}"
}
