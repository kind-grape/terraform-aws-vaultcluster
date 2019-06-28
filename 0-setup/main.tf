data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "../modules/aws-vpc"
  version = "1.66.0"

  name = "${lower(var.tags["client"])}-network"
  cidr = "${var.address_space}"

  enable_nat_gateway = true
  single_nat_gateway = false

  # one_nat_gateway_per_az  = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_dhcp_options              = true
  dhcp_options_domain_name         = "${lower(var.tags["client"])}.local"
  dhcp_options_domain_name_servers = "${var.dns_servers}"

  azs             = ["${data.aws_availability_zones.available.names}"]
  private_subnets = ["${var.subnets["private"]}"]
  public_subnets  = ["${var.subnets["public"]}"]

  tags = {
    client     = "${var.tags["client"]}"
    costcenter = "${var.tags["costcenter"]}"
  }
}
