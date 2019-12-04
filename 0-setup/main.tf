data "aws_availability_zones" "available" {}

module "vpc" {
  source = "../modules/aws-vpc"

  name = "${lower(var.tags["client"])}-network"
  cidr = var.address_space

  azs             = data.aws_availability_zones.available.names
  private_subnets = split(",", var.subnets["private"])
  public_subnets  = split(",", var.subnets["public"])

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_dhcp_options      = true
  dhcp_options_domain_name = "${lower(var.tags["client"])}.local"

  tags = {
    client     = var.tags["client"]
    costcenter = var.tags["costcenter"]
  }
}
