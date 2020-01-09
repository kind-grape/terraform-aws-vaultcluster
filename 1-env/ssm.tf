module "ssm_data" {
  source = "../modules/aws-ssm"

  region     = var.region
  join_tag   = local.vault["datacenter"]
  namespace  = lower(local.tags["client"])
  key_id     = module.kms.kms_id
  serverinfo = local.vault
  # module_depends_on = [module.certs.depends_on]
}
