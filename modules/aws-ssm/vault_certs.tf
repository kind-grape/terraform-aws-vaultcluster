resource "aws_ssm_parameter" "vault_server_tls_ca_bundle" {
  # depends_on = [var.module_depends_on]
  count     = local.serverinfo["tlslistener"] ? 1 : 0
  name      = "vault_tls_ca_bundle"
  type      = "SecureString"
  value     = file("${path.module}/../../${local.vault_root_cert}")
  key_id    = var.key_id
  overwrite = true
}

resource "aws_ssm_parameter" "vault_server_tls_cert" {
  # depends_on = [var.module_depends_on]
  count     = local.serverinfo["tlslistener"] ? 1 : 0
  name      = "vault_server_tls_cert"
  type      = "SecureString"
  value     = file("${path.module}/../../${local.vault_server_cert}")
  key_id    = var.key_id
  overwrite = true
}

resource "aws_ssm_parameter" "vault_server_tls_key" {
  # depends_on = [var.module_depends_on]
  count     = local.serverinfo["tlslistener"] ? 1 : 0
  name      = "vault_server_tls_key"
  type      = "SecureString"
  value     = file("${path.module}/../../${local.vault_server_key}")
  key_id    = var.key_id
  overwrite = true
}
