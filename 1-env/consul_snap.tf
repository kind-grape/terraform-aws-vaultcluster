module "consul_snap_sg" {
  source = "../modules/aws-security_group"
  create = local.consul_snap["count"] >= 1 ? true : false

  name        = "consulsnap_sg"
  description = "Security group consul service discovery"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = local.mgmt_subnets
  ingress_rules       = concat(var.ingress_rules, split(",", local.consul_snap["ingress_rules"]))
  egress_rules        = ["all-all"]

  tags = {
    client     = local.tags["client"]
    costcenter = local.tags["costcenter"]
  }
}

module "consul_snapshot_s3" {
  source = "../modules/aws-s3"

  serverinfo = local.consul_snap
  snapshots  = local.snapshots
  region     = var.region
  tags       = local.tags
}

module "consul_snapshot_user_data" {
  source = "../modules/aws-hashi_user_data"

  kms_key_id = module.kms.kms_id
  region     = var.region
  tags       = local.tags
  snapshots  = local.snapshots
  serverinfo = local.consul_snap
  ports      = local.ports
  bootstrap  = var.bootstrap # true or false
}

module "consul_snapshot" {
  source = "../modules/aws-asg"

  ami                  = data.aws_ami.consul.id
  user_data            = module.consul_snapshot_user_data.user_data
  security_groups      = [module.consul_snap_sg.this_security_group_id]
  iam_instance_profile = module.kms.iam_instance_profile
  subnet_id            = split(",", var.subnet_id)
  key_name             = var.key_name
  tags                 = local.tags
  serverinfo           = local.consul_snap
  cluster_name         = "${lower(local.tags["client"])}-${var.environment}-${var.region}-${local.consul_snap["role"]}"
}
