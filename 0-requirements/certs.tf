module "certs" {
  source = "../modules/cert_gen"

  region     = var.region
  domain     = var.domain
  certs      = local.certs
}
