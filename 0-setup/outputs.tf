output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = {
    private_subnets_cidr_blocks = module.vpc.private_subnets_cidr_blocks
    private_subnets_ids         = module.vpc.private_subnets
  }
}

output "public_subnets" {
  value = {
    public_subnets_cidr_blocks = module.vpc.public_subnets_cidr_blocks
    public_subnets_ids         = module.vpc.private_subnets
  }
}
