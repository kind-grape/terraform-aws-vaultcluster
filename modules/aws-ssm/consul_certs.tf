# NOTE: The Consul server and client certificates must both be signed by the same CA
resource "aws_ssm_parameter" "consul_tls_ca_bundle" {
  # depends_on = [var.module_depends_on]
  count     = local.serverinfo["tlslistener"] ? 1 : 0
  name      = "consul_tls_ca_bundle"
  type      = "SecureString"
  value     = file("${path.module}/../../${local.root_cert}")
  key_id    = var.key_id
  overwrite = true
}

resource "aws_ssm_parameter" "consul_server_tls_cert" {
  # depends_on = [var.module_depends_on]
  count     = local.serverinfo["tlslistener"] ? 1 : 0
  name      = "consul_server_tls_cert"
  type      = "SecureString"
  value     = file("${path.module}/../../${local.server_cert}")
  key_id    = var.key_id
  overwrite = true
}

resource "aws_ssm_parameter" "consul_server_tls_key" {
  # depends_on = [var.module_depends_on]
  count     = local.serverinfo["tlslistener"] ? 1 : 0
  name      = "consul_server_tls_key"
  type      = "SecureString"
  value     = file("${path.module}/../../${local.server_key}")
  key_id    = var.key_id
  overwrite = true
}

resource "aws_ssm_parameter" "consul_client_tls_cert" {
  # depends_on = [var.module_depends_on]
  count     = local.serverinfo["tlslistener"] ? 1 : 0
  name      = "consul_client_tls_cert"
  type      = "SecureString"
  value     = file("${path.module}/../../${local.client_cert}")
  key_id    = var.key_id
  overwrite = true
}

resource "aws_ssm_parameter" "consul_client_tls_key" {
  # depends_on = [var.module_depends_on]
  count     = local.serverinfo["tlslistener"] ? 1 : 0
  name      = "consul_client_tls_key"
  type      = "SecureString"
  value     = file("${path.module}/../../${local.client_key}")
  key_id    = var.key_id
  overwrite = true
}
